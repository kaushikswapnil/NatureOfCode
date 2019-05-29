/////////////////////////////
//Globals to define general behaviour

///////////////////////////

function setup()
{
	var A = new Matrix(2, 3);
	var B = new Matrix(3, 2);

	A.Randomize();
	B.Randomize();

	console.table(A.m_Matrix);
	console.table(B.m_Matrix);

	var C = Matrix.Multiply(A, B);
	console.table(C.m_Matrix);

	var D = C.GetTranspose();
	console.table(D.m_Matrix);
}

function draw()
{

}

