<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <style>
        body {
            background: #e2eef7;
            font-family: 'Avenir', Helvetica, sans-serif !important;
            margin: 0;
            overflow-x: hidden;
            color: #202020;
            font-weight: 400;
            font-size: 14;
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

        .right-sidebar {
            position: fixed;
            top: 0;
            right: -600px;
            /* Start with it hidden on the right side */
            width: 600px;
            height: 100%;
            background-color: white;
            transition: right 0.3s ease-in-out;
            z-index: 999;
        }

        /* Add transition effect when opening and closing the drawer */
        .right-sidebar.open {
            right: 0;
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
    <title>Charity Donation Tracker</title>
</head>

<body>

    <div class="container mt-4" style="border: 2px solid brown;max-width: 85%;">
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

            <button type="submit" onclick="searchCharityDonation()" class="btn btn-primary mt-2">Search</button>
        </form>
    </div>

    <!-- Display Search Results in a Table -->
    <div class="container mt-4 table-container" style="border: 2px solid brown;max-width: 85%;">
        <div>
            <h3 style="font-size: 16px;">Charity Donation Tracker
                <!-- Add Charity Icon -->
                <svg xmlns="http://www.w3.org/2000/svg" onclick="togglecharityDonationDiv()" height="26"
                    fill="currentColor" class="bi bi-plus" viewBox="0 0 16 16">
                    <path
                        d="M8 4a.5.5 0 0 1 .5.5v3h3a.5.5 0 0 1 0 1h-3v3a.5.5 0 0 1-1 0v-3h-3a.5.5 0 0 1 0-1h3v-3A.5.5 0 0 1 8 4z" />
                </svg>

            </h3>

        </div>
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
                    <th>Action</th>
                </tr>
            </thead>
            <tbody id="searchResults">
                <!-- Search results will be displayed here -->
            </tbody>
        </table>
    </div>

    <div class="right-sidebar" id="charityDonationDiv" style="background: #e2eef7;">
        <div class="slimscrollright">
            <div class="rpanel-title" style="padding-left: 20px;
                                padding-right: 20px;
                                padding-top: 8px;" onclick="cancelCharityDonation()" id="charityDonationDivTitle">
                Charity Donation <span> <button type="button" class="close" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </span>
            </div>
            <div class="r-panel-body">
                <div class="div-white p-3" style="background: white;
                                    margin: 20px;
                                    border: 3px solid lightgray;
                                    border-radius: 10px;">
                    <div class="row">
                        <div class="col-md-4">
                            <div class="form-group">
                                <label class="control-label font14">Financial Year</label>
                            </div>
                        </div>
                        <div class="col-md-8">
                            <input type="text" name="textBox" pattern="[A-Za-z0-9_]+" placeholder="Financial Year"
                                id="financialYear" class="form-control font-14" value="" required />
                        </div>
                    </div>

                    <div class="row">
                        <div class="col-md-4">
                            <div class="form-group">
                                <label class="control-label font14">Date</label>
                            </div>
                        </div>
                        <div class="col-md-8">
                            <input type="text" name="textBox" pattern="[A-Za-z0-9_]+" placeholder="Date" id="date"
                                class="form-control font-14" value="" required />
                        </div>
                    </div>

                    <div class="row">
                        <div class="col-md-4">
                            <div class="form-group">
                                <label class="control-label font14">Address</label>
                            </div>
                        </div>
                        <div class="col-md-8">
                            <input type="text" name="textBox" pattern="[A-Za-z0-9_]+" placeholder="Address" id="address"
                                class="form-control font-14" value="" required />
                        </div>
                    </div>

                    <div class="row">
                        <div class="col-md-4">
                            <div class="form-group">
                                <label class="control-label font14">Institute</label>
                            </div>
                        </div>
                        <div class="col-md-8">
                            <input type="text" name="textBox" pattern="[A-Za-z0-9_]+" placeholder="Institute"
                                id="institute" class="form-control font-14" value="" required />
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-md-4">
                            <div class="form-group">
                                <label class="control-label font14">Amount</label>
                            </div>
                        </div>
                        <div class="col-md-8">
                            <input type="text" name="textBox" pattern="[A-Za-z0-9_]+" placeholder="Amount" id="amount"
                                class="form-control font-14" value="" required />
                        </div>
                    </div>

                    <div class="row">
                        <div class="col-md-4">
                            <div class="form-group">
                                <label class="control-label font14">Receipt</label>
                            </div>
                        </div>
                        <div class="col-md-8">
                            <input type="text" name="textBox" pattern="[A-Za-z0-9_]+" placeholder="Receipt" id="receipt"
                                class="form-control font-14" value="" required />
                        </div>
                    </div>

                    <div class="row">
                        <div class="col-md-4">
                            <div class="form-group">
                                <label class="control-label font14">Pan Number</label>
                            </div>
                        </div>
                        <div class="col-md-8">
                            <input type="text" name="textBox" pattern="[A-Za-z0-9_]+" placeholder="Pan" id="pan"
                                class="form-control font-14" value="" required />
                        </div>
                    </div>

                    <div class="row">
                        <div class="col-md-4">
                            <div class="form-group">
                                <label class="control-label font14">Receipts</label>
                            </div>
                        </div>
                        <div class="col-md-8">
                            <input type="text" name="textBox" pattern="[A-Za-z0-9_]+" placeholder="Receipts"
                                id="receipts" class="form-control font-14" value="" required />
                        </div>
                    </div>

                    <div class="row">
                        <div class="col-md-4">
                            <div class="form-group">
                                <label class="control-label font14">Remarks</label>
                            </div>
                        </div>
                        <div class="col-md-8">
                            <input type="text" name="textBox" pattern="[A-Za-z0-9_]+" placeholder="Remarks" id="remarks"
                                class="form-control font-14" value="" required />
                        </div>
                    </div>
                    <div class="row p-3"></div>
                    <div class="row">
                        <div class="col-6">
                            <button type="button" class="btn waves-effect waves-light btn-rounded btn-danger"
                                onClick="cancelCharityDonation()">Cancel</button>
                        </div>
                        <div class="col-6 text-right">
                            <button type="button" id="saveCharityDonationBtn"
                                class="btn waves-effect waves-light btn-rounded btn-info"
                                onClick="saveCharity()">Add</button>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
    <script>

        function searchCharityDonation() {
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

                            const actionCell = document.createElement('td'); 
                            const editAnchor = document.createElement('a');
                            editAnchor.innerHTML =  `<svg xmlns="http://www.w3.org/2000/svg" onclick="editCharityDonation()" width="16" height="16" style="margin-right: 16px" fill="currentColor" class="bi bi-pencil" viewBox="0 0 16 16">
                            <path d="M12.146.146a.5.5 0 0 1 .708 0l3 3a.5.5 0 0 1 0 .708l-10 10a.5.5 0 0 1-.168.11l-5 2a.5.5 0 0 1-.65-.65l2-5a.5.5 0 0 1 .11-.168l10-10zM11.207 2.5 13.5 4.793 14.793 3.5 12.5 1.207 11.207 2.5zm1.586 3L10.5 3.207 4 9.707V10h.5a.5.5 0 0 1 .5.5v.5h.5a.5.5 0 0 1 .5.5v.5h.293l6.5-6.5zm-9.761 5.175-.106.106-1.528 3.821 3.821-1.528.106-.106A.5.5 0 0 1 5 12.5V12h-.5a.5.5 0 0 1-.5-.5V11h-.5a.5.5 0 0 1-.468-.325z"/>
                            </svg><svg xmlns="http://www.w3.org/2000/svg" onclick="deleteCharityDonation()" width="16" height="16" fill="currentColor" class="bi bi-trash" viewBox="0 0 16 16">
                            <path d="M5.5 5.5A.5.5 0 0 1 6 6v6a.5.5 0 0 1-1 0V6a.5.5 0 0 1 .5-.5Zm2.5 0a.5.5 0 0 1 .5.5v6a.5.5 0 0 1-1 0V6a.5.5 0 0 1 .5-.5Zm3 .5a.5.5 0 0 0-1 0v6a.5.5 0 0 0 1 0V6Z"/>
                            <path d="M14.5 3a1 1 0 0 1-1 1H13v9a2 2 0 0 1-2 2H5a2 2 0 0 1-2-2V4h-.5a1 1 0 0 1-1-1V2a1 1 0 0 1 1-1H6a1 1 0 0 1 1-1h2a1 1 0 0 1 1 1h3.5a1 1 0 0 1 1 1v1ZM4.118 4 4 4.059V13a1 1 0 0 0 1 1h6a1 1 0 0 0 1-1V4.059L11.882 4H4.118ZM2.5 3h11V2h-11v1Z"/>
                            </svg>`;
                            
                            actionCell.appendChild(editAnchor);

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
                            newRow.appendChild(actionCell);

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

                        const actionCell = document.createElement('td'); 
                            const editAnchor = document.createElement('a');
                            editAnchor.innerHTML =  `<svg xmlns="http://www.w3.org/2000/svg" onclick="editCharityDonation()" width="16" height="16" style="margin-right: 16px" fill="currentColor" class="bi bi-pencil" viewBox="0 0 16 16">
                            <path d="M12.146.146a.5.5 0 0 1 .708 0l3 3a.5.5 0 0 1 0 .708l-10 10a.5.5 0 0 1-.168.11l-5 2a.5.5 0 0 1-.65-.65l2-5a.5.5 0 0 1 .11-.168l10-10zM11.207 2.5 13.5 4.793 14.793 3.5 12.5 1.207 11.207 2.5zm1.586 3L10.5 3.207 4 9.707V10h.5a.5.5 0 0 1 .5.5v.5h.5a.5.5 0 0 1 .5.5v.5h.293l6.5-6.5zm-9.761 5.175-.106.106-1.528 3.821 3.821-1.528.106-.106A.5.5 0 0 1 5 12.5V12h-.5a.5.5 0 0 1-.5-.5V11h-.5a.5.5 0 0 1-.468-.325z"/>
                            </svg><svg xmlns="http://www.w3.org/2000/svg" onclick="deleteCharityDonation()" width="16" height="16" fill="currentColor" class="bi bi-trash" viewBox="0 0 16 16">
                            <path d="M5.5 5.5A.5.5 0 0 1 6 6v6a.5.5 0 0 1-1 0V6a.5.5 0 0 1 .5-.5Zm2.5 0a.5.5 0 0 1 .5.5v6a.5.5 0 0 1-1 0V6a.5.5 0 0 1 .5-.5Zm3 .5a.5.5 0 0 0-1 0v6a.5.5 0 0 0 1 0V6Z"/>
                            <path d="M14.5 3a1 1 0 0 1-1 1H13v9a2 2 0 0 1-2 2H5a2 2 0 0 1-2-2V4h-.5a1 1 0 0 1-1-1V2a1 1 0 0 1 1-1H6a1 1 0 0 1 1-1h2a1 1 0 0 1 1 1h3.5a1 1 0 0 1 1 1v1ZM4.118 4 4 4.059V13a1 1 0 0 0 1 1h6a1 1 0 0 0 1-1V4.059L11.882 4H4.118ZM2.5 3h11V2h-11v1Z"/>
                            </svg>`;
                            
                            actionCell.appendChild(editAnchor);

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
                        newRow.appendChild(actionCell);

                        // Append the row to the search results table
                        searchResults.appendChild(newRow);
                    }
                })
                .catch(error => {
                    console.log('API call failed: ' + error);
                });
        }

        function togglecharityDonationDiv() {
            var div = document.getElementById('charityDonationDiv');
            div.classList.toggle('open');
        }

        function cancelCharityDonation() {
            document.getElementById('charityDonationDiv').classList.remove('open');
        }

        function saveCharity() {
            const charityDonationData = {};
            charityDonationData.financialYear = document.getElementById('financialYear').value;
            charityDonationData.date = document.getElementById('date').value;
            charityDonationData.address = document.getElementById('address').value;
            charityDonationData.institution = document.getElementById('institute').value;
            charityDonationData.amount = document.getElementById('amount').value;
            charityDonationData.receipt = document.getElementById('receipt').value;
            charityDonationData.pan = document.getElementById('pan').value;
            charityDonationData.receipts = document.getElementById('receipts').value;
            charityDonationData.remarks = document.getElementById('remarks').value;

            fetch('http://localhost:8081/api/CharityDonations', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json',
                },
                body: JSON.stringify(charityDonationData),
            })
                .then(response => response.json())
                .then(data => {
                    console.log('Charity Donation saved:', data);
                    document.getElementById('charityDonationDiv').classList.remove('open');
                    fetchAllCharityDonations();
                })
                .catch(error => {
                    console.error('Error saving Charity Donation:', error);
                });
        }

        function fetchAllCharityDonations() {
            const url = 'http://localhost:8081/api/CharityDonations';

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

                            // Create table cells for each field in the data and append them to the row

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

                            const actionCell = document.createElement('td'); 
                            const editAnchor = document.createElement('a');
                            editAnchor.innerHTML =  `<svg xmlns="http://www.w3.org/2000/svg" onclick="editCharityDonation()" width="16" height="16" style="margin-right: 16px" fill="currentColor" class="bi bi-pencil" viewBox="0 0 16 16">
                            <path d="M12.146.146a.5.5 0 0 1 .708 0l3 3a.5.5 0 0 1 0 .708l-10 10a.5.5 0 0 1-.168.11l-5 2a.5.5 0 0 1-.65-.65l2-5a.5.5 0 0 1 .11-.168l10-10zM11.207 2.5 13.5 4.793 14.793 3.5 12.5 1.207 11.207 2.5zm1.586 3L10.5 3.207 4 9.707V10h.5a.5.5 0 0 1 .5.5v.5h.5a.5.5 0 0 1 .5.5v.5h.293l6.5-6.5zm-9.761 5.175-.106.106-1.528 3.821 3.821-1.528.106-.106A.5.5 0 0 1 5 12.5V12h-.5a.5.5 0 0 1-.5-.5V11h-.5a.5.5 0 0 1-.468-.325z"/>
                            </svg><svg xmlns="http://www.w3.org/2000/svg" onclick="deleteCharityDonation()" width="16" height="16" fill="currentColor" class="bi bi-trash" viewBox="0 0 16 16">
                            <path d="M5.5 5.5A.5.5 0 0 1 6 6v6a.5.5 0 0 1-1 0V6a.5.5 0 0 1 .5-.5Zm2.5 0a.5.5 0 0 1 .5.5v6a.5.5 0 0 1-1 0V6a.5.5 0 0 1 .5-.5Zm3 .5a.5.5 0 0 0-1 0v6a.5.5 0 0 0 1 0V6Z"/>
                            <path d="M14.5 3a1 1 0 0 1-1 1H13v9a2 2 0 0 1-2 2H5a2 2 0 0 1-2-2V4h-.5a1 1 0 0 1-1-1V2a1 1 0 0 1 1-1H6a1 1 0 0 1 1-1h2a1 1 0 0 1 1 1h3.5a1 1 0 0 1 1 1v1ZM4.118 4 4 4.059V13a1 1 0 0 0 1 1h6a1 1 0 0 0 1-1V4.059L11.882 4H4.118ZM2.5 3h11V2h-11v1Z"/>
                            </svg>`;
                            
                            actionCell.appendChild(editAnchor);

                            
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
                            newRow.appendChild(actionCell);

                            // Append the row to the search results table
                            searchResults.appendChild(newRow);
                        });
                    }
                })
                .catch(error => {
                    console.log('API call failed: ' + error);
                });
        }

        function editCharityDonation() {
            console.log("hello edit");
        }

        function deleteCharityDonation() {
            console.log("hello delete");
        }

        window.onload = fetchAllCharityDonations;
    </script>
</body>

</html>