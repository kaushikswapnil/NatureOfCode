function sigmoid(x)
{
	return (1 / (1 + Math.exp(-x)));
}


class NeuralNetwork
{
	constructor(numInputNodes, numHiddenNodes, numOutputNodes)
	{
		this.m_NumInputNodes = numInputNodes;
		this.m_NumHiddenNodes = numHiddenNodes;
		this.m_NumOutputNodes = numOutputNodes;

		this.m_WeightsIH = new Matrix(numHiddenNodes. numInputNodes);
		this.m_WeightsHO = new Matrix(numOutputNodes. numHiddenNodes);

		this.m_WeightsIH.Randomize();
		this.m_WeightsHO.Randomize();

		this.m_BiasH = new Matrix(numHiddenNodes, 1);
		this.m_BiasO = new Matrix(numOutputNodes, 1);

		this.m_BiasH.Randomize();
		this.m_BiasO.Randomize();
	}

	FeedForward(inputsArray)
	{
		//Generating hidden layer output
		let inputsMatrix = Matrix.FromArray(inputsArray);

		let hiddenOutput = Matrix.Multiply(this.m_WeightsIH, inputsMatrix);
		hiddenOutput.Add(this.m_BiasH);

		//Hidden layer activation func
		hiddenOutput.map(sigmoid);

		/////End of hidden layer
	}
}
