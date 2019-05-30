/////////////////////////////
//Globals to define general behaviour

///////////////////////////

function setup()
{
	var A = new Matrix(2, 3);
	var B = new Matrix(3, 2);

	A.Randomize();
	B.Randomize();

	console.table(A.m_MatrixData);
	console.table(B.m_MatrixData);

	var C = Matrix.Multiply(A, B);
	console.table(C.m_MatrixData);

	var D = C.GetTranspose();
	console.table(D.m_MatrixData);

	var creatorArray = [0, 1, 2];
	var E = Matrix.FromArray(creatorArray);
	console.table(E.m_MatrixData);
}

function draw()
{

}

