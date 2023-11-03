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

        th,
        td {
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
                    <input type="radio" class="form-check-input" name="searchBy" value="institution"
                        id="radioInstitution">
                    <label class="form-check-label" for="radioInstitution">Institution</label>
                </div>
                <div class="form-check form-check-inline">
                    <input type="radio" class="form-check-input" name="searchBy" value="financialYear"
                        id="radioFinancialYear">
                    <label class="form-check-label" for="radioFinancialYear">Financial Year</label>
                </div>
                <div class="form-check form-check-inline">
                    <input type="radio" class="form-check-input" name="searchBy" value="receipts" id="radioReceipts">
                    <label class="form-check-label" for="radioReceipts">Receipts</label>
                </div>
                <div class="form-check form-check-inline">
                    <input type="radio" class="form-check-input" name="searchBy" value="address" id="radioAddresss">
                    <label class="form-check-label" for="radioAddresss">Address</label>
                </div>
                <div class="form-check form-check-inline">
                    <input type="radio" class="form-check-input" name="searchBy" value="pan" id="radioPan">
                    <label class="form-check-label" for="radioPan">Pan</label>
                </div>
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

                const url = 'http://localhost:8081/api/CharityDonations/' + document.querySelector('input[name="searchBy"]:checked').value + '/' + document.getElementById('searchInput').value;

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
                        const searchResults = document.getElementById('searchResults');
                        searchResults.innerHTML = '';

                        if (Array.isArray(data)) {
                            data.forEach(item => {
                                const newRow = document.createElement('tr');

                                const idCell = document.createElement('td');
                                idCell.textContent = item.id;

                                const financialYearCell = document.createElement('td');
                                financialYearCell.textContent = item.financialYear;

                                const dateCell = document.createElement('td');
                                dateCell.textContent = item.date;

                                const receiptCell = document.createElement('td');
                                receiptCell.textContent = item.receipt;

                                const amountCell = document.createElement('td');
                                amountCell.textContent = item.amount;

                                const institutionCell = document.createElement('td');
                                institutionCell.textContent = item.institution;

                                const addressCell = document.createElement('td');
                                addressCell.textContent = item.address;

                                const panCell = document.createElement('td');
                                panCell.textContent = item.pan;

                                const receiptsCell = document.createElement('td');
                                receiptsCell.textContent = item.receipts;

                                const remarksCell = document.createElement('td');
                                remarksCell.textContent = item.remarks;

                                // Append the cells to the row in the desired order
                                newRow.appendChild(idCell);
                                newRow.appendChild(financialYearCell);
                                newRow.appendChild(dateCell);
                                newRow.appendChild(receiptCell);
                                newRow.appendChild(amountCell);
                                newRow.appendChild(institutionCell);
                                newRow.appendChild(addressCell);
                                newRow.appendChild(panCell);
                                newRow.appendChild(receiptsCell);
                                newRow.appendChild(remarksCell);

                                searchResults.appendChild(newRow);
                            });
                        } else if (typeof data === 'object') {
                            const newRow = document.createElement('tr');

                            const idCell = document.createElement('td');
                            idCell.textContent = data.id;

                            const financialYearCell = document.createElement('td');
                            financialYearCell.textContent = data.financialYear;

                            const dateCell = document.createElement('td');
                            dateCell.textContent = data.date;

                            const receiptCell = document.createElement('td');
                            receiptCell.textContent = data.receipt;

                            const amountCell = document.createElement('td');
                            amountCell.textContent = data.amount;

                            const institutionCell = document.createElement('td');
                            institutionCell.textContent = data.institution;

                            const addressCell = document.createElement('td');
                            addressCell.textContent = data.address;

                            const panCell = document.createElement('td');
                            panCell.textContent = data.pan;

                            const receiptsCell = document.createElement('td');
                            receiptsCell.textContent = data.receipts;

                            const remarksCell = document.createElement('td');
                            remarksCell.textContent = data.remarks;

                            // Append the cells to the row in the desired order
                            newRow.appendChild(idCell);
                            newRow.appendChild(financialYearCell);
                            newRow.appendChild(dateCell);
                            newRow.appendChild(receiptCell);
                            newRow.appendChild(amountCell);
                            newRow.appendChild(institutionCell);
                            newRow.appendChild(addressCell);
                            newRow.appendChild(panCell);
                            newRow.appendChild(receiptsCell);
                            newRow.appendChild(remarksCell);

                            // Append the row to the search results table
                            searchResults.appendChild(newRow);
                        }
                    })
                    .catch(error => {
                        console.log('API call failed: ' + error);
                    });
            });
        });

    </script>
</body>

</html>