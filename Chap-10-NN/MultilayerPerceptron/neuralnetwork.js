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

		let hiddenOutputMatrix = Matrix.Multiply(this.m_WeightsIH, inputsMatrix);
		hiddenOutputMatrix.Add(this.m_BiasH);

		//Hidden layer activation func
		hiddenOutputMatrix.Map(Sigmoid);

		if (outHiddenOutputMatrix != undefined)
		{
			outHiddenOutputMatrix.m_Rows = hiddenOutputMatrix.m_Rows;
			outHiddenOutputMatrix.m_Cols = hiddenOutputMatrix.m_Cols;
			outHiddenOutputMatrix.m_MatrixData = hiddenOutputMatrix.m_MatrixData;
		}
		/////End of hidden layer

		//Output layer
		let outputOutputMatrix = Matrix.Multiply(this.m_WeightsHO, hiddenOutputMatrix);
		outputOutputMatrix.Add(this.m_BiasO);

		outputOutputMatrix.Map(Sigmoid);
		//End of output layer

		return Matrix.ToArray(outputOutputMatrix);
	}

	Train(inputsArray, desiredArray)
	{
		let hiddenOutputMatrix = new Matrix(this.m_NumHiddenNodes, 1);
		let guessArray = this.FeedForward(inputsArray, hiddenOutputMatrix);

		let outputErrorMatrix = Matrix.Subtract(Matrix.FromArray(desiredArray), Matrix.FromArray(guessArray));

		//#TODO Use normalization
		let weightsHOTranspose = Matrix.Transpose(this.m_WeightsHO);
		let hiddenErrorMatrix = Matrix.Multiply(weightsHOTranspose, outputErrorMatrix);

		let weightsIHTranspose = Matrix.Transpose(this.m_WeightsIH);
		let inputErrorMatrix = Matrix.Multiply(weightsIHTranspose, hiddenErrorMatrix);


	}
}
