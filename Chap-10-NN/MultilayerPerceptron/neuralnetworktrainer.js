function XORTrainingDataCreationFunc()
{
	var caseSpecifier = Math.floor(Math.random() * 4);

	switch(caseSpecifier)
	{
		case 0:
		return new TrainingData([0, 0], [0]);
		break;

		case 1:
		return new TrainingData([1, 0], [1]);
		break;

		case 2:
		return new TrainingData([0, 1], [1]);
		break;

		case 3:
		return new TrainingData([1, 1], [0]);
		break;

		default:
		return undefined;
	}
}

class TrainingData
{
	constructor(inputArray, desiredOutputArray)
	{
		this.m_InputArray = inputArray;
		this.m_DesiredOutputArray = desiredOutputArray
	}
}

class NeuralNetworkTrainer
{
	constructor(numTrainingData, creationFuncPtr) //the creation function pointer should create one of these training data variables and send it back.
	{
	    this.m_TrainingDataArray = [];
		for (var iter = 0; iter < numTrainingData; ++iter)
		{
			this.m_TrainingDataArray[iter] = creationFuncPtr();
		}
	}

	Train(neuralNetwork)
	{
		for (var iter = 0; iter < this.m_TrainingDataArray.length; ++iter)
		{
			neuralNetwork.Train(this.m_TrainingDataArray[iter].m_InputArray, this.m_TrainingDataArray[iter].m_DesiredOutputArray)
		}
	}
}