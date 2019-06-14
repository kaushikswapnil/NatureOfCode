function Sigmoid(x)
{
	return (1 / (1 + Math.exp(-x)));
}

function SigmoidDerivative(sigmoidValue)
{
	return (sigmoidValue*(1-sigmoidValue));
}

class NeuralNetwork
{
	constructor(numInputNodes, numHiddenNodes, numOutputNodes, learningRate)
	{
		this.m_NumInputNodes = numInputNodes;
		this.m_NumHiddenNodes = numHiddenNodes;
		this.m_NumOutputNodes = numOutputNodes;
		this.m_LearningRate = learningRate;

		this.m_WeightsIH = new Matrix(numHiddenNodes, numInputNodes);
		this.m_WeightsHO = new Matrix(numOutputNodes, numHiddenNodes);

		this.m_WeightsIH.Randomize();
		this.m_WeightsHO.Randomize();

		this.m_BiasH = new Matrix(numHiddenNodes, 1);
		this.m_BiasO = new Matrix(numOutputNodes, 1);

		this.m_BiasH.Randomize();
		this.m_BiasO.Randomize();
	}

	FeedForward(inputsArray, outHiddenOutputMatrix)
	{
		//Generating hidden layer output
		let inputsMatrix = Matrix.FromArray(inputsArray);

		let hiddenOutputMatrix = Matrix.CrossMultiply(this.m_WeightsIH, inputsMatrix);
		hiddenOutputMatrix.Add(this.m_BiasH);

		//Hidden layer activation func
		hiddenOutputMatrix = Matrix.Map(hiddenOutputMatrix, Sigmoid);

		if (outHiddenOutputMatrix != undefined)
		{
			outHiddenOutputMatrix.m_Rows = hiddenOutputMatrix.m_Rows;
			outHiddenOutputMatrix.m_Cols = hiddenOutputMatrix.m_Cols;
			outHiddenOutputMatrix.m_MatrixData = hiddenOutputMatrix.m_MatrixData;
		}
		/////End of hidden layer

		//Output layer
		let outputOutputMatrix = Matrix.CrossMultiply(this.m_WeightsHO, hiddenOutputMatrix);
		outputOutputMatrix.Add(this.m_BiasO);

		outputOutputMatrix = Matrix.Map(outputOutputMatrix,Sigmoid);
		//End of output layer

		return Matrix.ToArray(outputOutputMatrix);
	}

	Train(inputsArray, desiredArray)
	{
		let hiddenOutputMatrix = new Matrix(this.m_NumHiddenNodes, 1);
		let guessArray = this.FeedForward(inputsArray, hiddenOutputMatrix);

		let outputErrorMatrix = Matrix.Subtract(Matrix.FromArray(desiredArray), Matrix.FromArray(guessArray));

		//#TODO Use normalization
		let outputGradient = Matrix.Map(Matrix.FromArray(guessArray), SigmoidDerivative);
		outputGradient = Matrix.DotMultiply(outputGradient, outputErrorMatrix);
		outputGradient = Matrix.DotMultiply(outputGradient, this.m_LearningRate);

		let hiddenOutputTranspose = Matrix.Transpose(hiddenOutputMatrix);
		let weightsHODeltas = Matrix.CrossMultiply(outputGradient, hiddenOutputTranspose);

		this.m_BiasO.Add(outputGradient);
		this.m_WeightsHO.Add(weightsHODeltas);

		let weightsHOTranspose = this.m_WeightsHO.GetTranspose();
		let hiddenErrorMatrix = Matrix.CrossMultiply(weightsHOTranspose, outputErrorMatrix);

		let hiddenGradient = Matrix.Map(hiddenOutputMatrix, SigmoidDerivative);
		hiddenGradient = Matrix.DotMultiply(hiddenGradient, hiddenErrorMatrix);
		hiddenGradient = Matrix.DotMultiply(hiddenGradient, this.m_LearningRate);

		let inputTranspose = Matrix.Transpose(Matrix.FromArray(inputsArray));
		let wieghtsIHDeltas = Matrix.CrossMultiply(hiddenGradient, inputTranspose);

		this.m_BiasH.Add(hiddenGradient);
		this.m_WeightsIH.Add(wieghtsIHDeltas);
	}
}
