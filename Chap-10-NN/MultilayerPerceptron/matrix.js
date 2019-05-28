class Matrix
{
	constructor(rows, cols)
	{
		this.m_Rows = rows;
		this.m_Cols = cols;

		this.m_Matrix = [];

		for (var rowIter = 0; rowIter < this.m_Rows; ++rowIter)
		{
			this.m_Matrix[rowIter] = [];

			for (var colIter = 0; colIter < this.m_Cols; ++colIter)
			{
				this.m_Matrix[rowIter][colIter] = 0;
			}
		}
	}

	Randomize()
	{
		for (var rowIter = 0; rowIter < this.m_Rows; ++rowIter)
		{
			for (var colIter = 0; colIter < this.m_Cols; ++colIter)
			{
				this.m_Matrix[rowIter][colIter] = Math.floor(Math.random() * 5);
			}
		}	
	}

	Scale(value)
	{
		for (var rowIter = 0; rowIter < this.m_Rows; ++rowIter)
		{
			for (var colIter = 0; colIter < this.m_Cols; ++colIter)
			{
				this.m_Matrix[rowIter][colIter] *= value;
			}
		}
	}
	
	Add(value)
	{	
		if (value instanceof Matrix)
		{
			for (var rowIter = 0; rowIter < this.m_Rows; ++rowIter)
			{
				for (var colIter = 0; colIter < this.m_Cols; ++colIter)
				{
					this.m_Matrix[rowIter][colIter] += value.m_Matrix[rowIter][colIter];
				}
			}
		}
		else
		{
			for (var rowIter = 0; rowIter < this.m_Rows; ++rowIter)
			{
				for (var colIter = 0; colIter < this.m_Cols; ++colIter)
				{
					this.m_Matrix[rowIter][colIter] += value;
				}
			}
		}
		
	}

	static Multiply(matrixA, matrixB)
	{
		if (!(matrixA instanceof Matrix) || !(matrixB instanceof Matrix))
		{
			console.log("You can only Multiply matrices with this function");
			return undefined;
		}

		var newMatrixRows = matrixA.m_Rows;
		var newMatrixCols = matrixB.m_Cols;

		if (matrixA.m_Cols != matrixB.m_Rows)
		{
			console.log("A.m_Cols != B.m_Rows");
			return undefined;
		}

		let temp = new Matrix(newMatrixRows, newMatrixCols);

		for (var newMatrixRowIter = 0; newMatrixRowIter < newMatrixRows; ++newMatrixRowIter)
		{
			for (var newMatrixColIter = 0; newMatrixColIter < newMatrixCols; ++newMatrixColIter)
			{
				let valueAtPos = 0;

				for (var colIter = 0; colIter < matrixA.m_Cols; ++colIter)
				{
					valueAtPos += matrixA.m_Matrix[newMatrixRowIter][colIter] * matrixB.m_Matrix[colIter][newMatrixColIter];
				}

				temp.m_Matrix[newMatrixRowIter][newMatrixColIter] = valueAtPos;
			}
		}

		return temp;
	}

	GetTranspose()
	{
		var newMatrixRows = this.m_Cols;
		var newMatrixCols = this.m_Rows;

		var temp = new Matrix(newMatrixRows, newMatrixCols);

		for (var newMatrixRowIter = 0; newMatrixRowIter < newMatrixRows; ++newMatrixRowIter)
		{
			for (var rowIter = 0; rowIter < this.m_Rows; ++rowIter)
			{
				temp.m_Matrix[newMatrixRowIter][rowIter] = this.m_Matrix[rowIter][newMatrixRowIter];
			}
		}

		return temp;
	}
}