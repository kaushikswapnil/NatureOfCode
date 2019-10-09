/////////////////////////////
//Globals to define general behaviour

///////////////////////////

var neuralNetwork;

function setup()
{
	neuralNetwork = new NeuralNetwork(2, 3, 1, 0.35);

	var networkTrainer = new NeuralNetworkTrainer(4000, XORTrainingDataCreationFunc);

	networkTrainer.Train(neuralNetwork);

	var output = neuralNetwork.FeedForward([1, 1]);
	console.log(output);

	createCanvas(800, 800);
}

function draw()
{
	background(255);

	for (var widthIter = 0; widthIter < width; ++widthIter)
	{
		for (var heightIter = 0; heightIter < height; ++heightIter) 
		{
			var x1 = widthIter/width;
			var x2 = heightIter/height;

			var output = neuralNetwork.FeedForward([1, 1]);
			console.log(output);	
		}
	}
}

