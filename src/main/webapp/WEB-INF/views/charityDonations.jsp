<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
	<style>
		body {
			background-color: #f0f0f0;
		}

		.container {
			background-color: aliceblue;
			padding: 20px;
			border-radius: 10px;
		}

		.form-group.form-inline {
			margin-bottom: 10px;
		}

		.btn-primary {
			background-color: #007bff;
			border-color: #007bff;
		}

		.btn-primary:hover {
			background-color: #0056b3;
		}

		table {
			border: 1px solid #ccc;
		}

		th, td {
			border: 1px solid #ccc;
			padding: 8px;
		}

		.table-container {
			margin-top: 20px;
		}
		.radiobtn {
			background-color: lavender;
			border-radius: 10px;
		}

		.radiobtn .form-check-input {
			background-color: #fff;
			border: 1px solid #000;
			border-radius: 50%;
		}

		.radiobtn .form-check-label {
			color: #000;
		}

		.radiobtn .form-check-input:checked {
			background-color: #007bff;
			border: 1px solid #007bff;
		}

		.textLable {
			color: brown !important;
			font-size: 18px !important;
			font-weight: bold;

		}
	</style>
	<title>Data Search</title>
</head>
<body>

<div class="container mt-4" style="border: 2px solid brown;">
	<!-- Search Form -->
	<form id="searchForm">
		<div class="form-group form-inline">
			<label for="searchInput" class="mr-2 textLable">Please enter your data to be searched:</label>
			<input type="text" class="form-control" id="searchInput" name="searchInput">
		</div>
		<div class="form-group form-inline">
			<label class="mr-2 textLable">Please select the type of data to search:</label>
		</div>
		<div class="form-group form-inline radiobtn px-2 py-3">
			<div class="form-check form-check-inline">
				<input type="radio" class="form-check-input" name="searchBy" value="id" id="radioId">
				<label class="form-check-label" for="radioId">Id</label>
			</div>
			<div class="form-check form-check-inline">
				<input type="radio" class="form-check-input" name="searchBy" value="Institution" id="radioInstitution">
				<label class="form-check-label" for="radioInstitution">Institution</label>
			</div>
			<div class="form-check form-check-inline">
				<input type="radio" class="form-check-input" name="searchBy" value="financialYear" id="radioFinancialYear">
				<label class="form-check-label" for="radioFinancialYear">Financial Year</label>
			</div>
			<div class="form-check form-check-inline">
				<input type="radio" class="form-check-input" name="searchBy" value="Receipts" id="radioReceipts">
				<label class="form-check-label" for="radioReceipts">Receipts</label>
			</div>
			<div class="form-check form-check-inline">
				<input type="radio" class="form-check-input" name="searchBy" value="address" id="radioAddresss">
				<label class="form-check-label" for="radioAddresss">Address</label>
			</div>
			<div class="form-check form-check-inline">
				<input type="radio" class="form-check-input" name="searchBy" value="date" id="radioDate">
				<label class="form-check-label" for="radioDate">Date</label>
			</div>
			<!-- Add radio buttons for other search criteria as needed -->
		</div>

		<button type="submit" class="btn btn-primary mt-2">Search</button>
	</form>
</div>

<!-- Display Search Results in a Table -->
<div class="container mt-4 table-container" style="border: 2px solid brown;">
	<table class="table">
		<thead>
		<tr>
			<th>ID</th>
			<th>Financial Year</th>
			<th>Date</th>
			<th>Receipt</th>
			<th>Amount</th>
			<th>Institution</th>
			<th>Address</th>
			<th>PAN</th>
			<th>Receipts</th>
			<th>Remarks</th>
		</tr>
		</thead>
		<tbody id="searchResults">
		<!-- Search results will be displayed here -->
		</tbody>
	</table>
</div>

<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
<script>
document.addEventListener("DOMContentLoaded", function () {
const searchForm = document.getElementById('searchForm');
searchForm.addEventListener('submit', function (event) {
event.preventDefault();

const searchInput = document.getElementById('searchInput').value;
const searchField = document.querySelector('input[name="searchBy"]:checked').value;
console.log(searchField + " radio option clicked");

const url = `http://localhost:8081/api/CharityDonations/${searchField}/${searchInput}`;

fetch(url, {
method: 'GET',
headers: {
'Content-Type': 'application/json'
}
})
.then(response => {
if (response.ok) {
return response.json();
} else {
throw new Error('API call failed');
}
})
.then(data => {
const apiData = document.getElementById('apiData');
apiData.innerHTML = '';

data.forEach(item => {
apiData.innerHTML += `
<tr>
	<td>${item.id}</td>
	<td>${item.financialYear}</td>
	<td>${item.date}</td>
	<td>${item.receipt}</td>
	<td>${item.amount}</td>
	<td>${item.institution}</td>
	<td>${item.address}</td>
	<td>${item.pan}</td>
	<td>${item.receipts}</td>
	<td>${item.remarks}</td>
</tr>`;
});
})
.catch(error => {
console.log('API call failed: ' + error);
});
});
});

</script>
</body>
</html>
