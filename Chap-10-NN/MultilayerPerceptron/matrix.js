class Matrix
{
	constructor(rows, cols)
	{
		this.m_Rows = rows;
		this.m_Cols = cols;

		this.m_MatrixData = [];

		for (var rowIter = 0; rowIter < this.m_Rows; ++rowIter)
		{
			this.m_MatrixData[rowIter] = [];

			for (var colIter = 0; colIter < this.m_Cols; ++colIter)
			{
				this.m_MatrixData[rowIter][colIter] = 0;
			}
		}
	}

	static FromArray(arr)
	{
		let newMatrix = new Matrix(arr.length, 1);
		for(var iter = 0; iter < arr.length; ++iter)
		{
			newMatrix.m_MatrixData[iter][0] = arr[iter];
		}

		return newMatrix;
	}

	static ToArray(matrixValue)
	{
		let retArray = [];

		for (var rowIter = 0; rowIter < matrixValue.m_Rows; ++rowIter)
		{
			for (var colIter = 0; colIter < matrixValue.m_Cols; ++colIter)
			{
				retArray.push(matrixValue.m_MatrixData[rowIter][colIter]);
			}
		}

		return retArray;
	}

	static Add(matrixA, matrixB)
	{
		if (matrixA.m_Rows == matrixB.m_Rows && matrixA.m_Cols == matrixB.m_Cols)
		{
			let result = new Matrix(matrixA.m_Rows, matrixA.m_Cols);

			for (var rowIter = 0; rowIter < matrixA.m_Rows; ++rowIter)
			{
				for (var colIter = 0; colIter < matrixA.m_Cols; ++colIter)
				{
					result.m_MatrixData[rowIter][colIter] = matrixA.m_MatrixData[rowIter][colIter] + matrixB.m_MatrixData[rowIter][colIter];
				}
			}

			return result;
		}

		console.log("You can only add two matrices when they have the same number of cols and rows");
		return undefined;
	}

	static Subtract(matrixA, matrixB)
	{
		if (matrixA.m_Rows == matrixB.m_Rows && matrixA.m_Cols == matrixB.m_Cols)
		{
			let result = new Matrix(matrixA.m_Rows, matrixA.m_Cols);

			for (var rowIter = 0; rowIter < matrixA.m_Rows; ++rowIter)
			{
				for (var colIter = 0; colIter < matrixA.m_Cols; ++colIter)
				{
					result.m_MatrixData[rowIter][colIter] = matrixA.m_MatrixData[rowIter][colIter] - matrixB.m_MatrixData[rowIter][colIter];
				}
			}

			return result;
		}

		console.log("You can only subtract two matrices when they have the same number of cols and rows");
		return undefined;
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
					valueAtPos += matrixA.m_MatrixData[newMatrixRowIter][colIter] * matrixB.m_MatrixData[colIter][newMatrixColIter];
				}

				temp.m_MatrixData[newMatrixRowIter][newMatrixColIter] = valueAtPos;
			}
		}

		return temp;
	}

	Randomize()
	{
		for (var rowIter = 0; rowIter < this.m_Rows; ++rowIter)
		{
			for (var colIter = 0; colIter < this.m_Cols; ++colIter)
			{
				this.m_MatrixData[rowIter][colIter] = Math.floor(Math.random() * 2) - 1;
			}
		}	
	}

	Map(func)
	{
		for (var rowIter = 0; rowIter < this.m_Rows; ++rowIter)
		{
			for (var colIter = 0; colIter < this.m_Cols; ++colIter)
			{
				let valueAtPos = this.m_MatrixData[rowIter][colIter];
				this.m_MatrixData[rowIter][colIter] = func(valueAtPos);
			}
		}	
	}

	Scale(value)
	{
		for (var rowIter = 0; rowIter < this.m_Rows; ++rowIter)
		{
			for (var colIter = 0; colIter < this.m_Cols; ++colIter)
			{
				this.m_MatrixData[rowIter][colIter] *= value;
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
					this.m_MatrixData[rowIter][colIter] += value.m_MatrixData[rowIter][colIter];
				}
			}
		}
		else
		{
			for (var rowIter = 0; rowIter < this.m_Rows; ++rowIter)
			{
				for (var colIter = 0; colIter < this.m_Cols; ++colIter)
				{
					this.m_MatrixData[rowIter][colIter] += value;
				}
			}
		}
		
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
				temp.m_MatrixData[newMatrixRowIter][rowIter] = this.m_MatrixData[rowIter][newMatrixRowIter];
			}
		}

		return temp;
	}

	Print()
	{
		console.table(this.m_MatrixData);
	}
}