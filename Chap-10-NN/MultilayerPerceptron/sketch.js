/////////////////////////////
//Globals to define general behaviour

///////////////////////////

function setup()
{
	var neuralNetwork = new NeuralNetwork(3, 3, 2, 0.08);

	var inputs = [0, 1, 2];

	var outputs = neuralNetwork.FeedForward(inputs);

	neuralNetwork.Train(inputs, [1, 2]);
}

function draw()
{

}

