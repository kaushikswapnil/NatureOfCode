/////////////////////////////
//Globals to define general behaviour

///////////////////////////

function setup()
{
	var neuralNetwork = new NeuralNetwork(2, 3, 1, 0.35);

	var networkTrainer = new NeuralNetworkTrainer(4000, XORTrainingDataCreationFunc);

	networkTrainer.Train(neuralNetwork);

	var output = neuralNetwork.FeedForward([1, 1]);
	console.log(output);
}

function draw()
{

}

