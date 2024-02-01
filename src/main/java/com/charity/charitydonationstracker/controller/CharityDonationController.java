package com.charity.charitydonationstracker.controller;

import com.charity.charitydonationstracker.entity.CharityDonation;
import com.charity.charitydonationstracker.exception.ResourceNotFoundException;
import com.charity.charitydonationstracker.repository.CharityDonationsRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@CrossOrigin("http://localhost:4200/")
@RestController
@RequestMapping("/api")
public class CharityDonationController {

    @Autowired
    private CharityDonationsRepository charityDonationsRepository;

    @GetMapping("/charityDonation")
    public List<CharityDonation> getAllCharityDonation() {
        return charityDonationsRepository.findAll();
    }

    @PostMapping("/charityDonation")
    public CharityDonation createCharityDonation(@RequestBody CharityDonation charityDonation) {
        return charityDonationsRepository.save(charityDonation);
    }

    @GetMapping("/charityDonation/{id}")
    public ResponseEntity<CharityDonation> getCharityDonationById(@PathVariable Long id) {
        CharityDonation charityDonation = charityDonationsRepository.findById(id)
                 .orElseThrow(() -> new ResourceNotFoundException("Charity Donation with the given id not available" + id));
        return ResponseEntity.ok(charityDonation);
    }

    @PutMapping("/charityDonation/{id}")
    public ResponseEntity<CharityDonation> updateCharityDonation(@PathVariable Long id, @RequestBody CharityDonation charityDonationDetails) {
        CharityDonation charityDonation = charityDonationsRepository.findById(id)
                .orElseThrow(() -> new ResourceNotFoundException("Charity Donation with the given id not available" + id));
        charityDonation.setFinancialYear(charityDonationDetails.getFinancialYear());
        charityDonation.setDate(charityDonationDetails.getDate());
        charityDonation.setReceipt(charityDonationDetails.getReceipt());
        charityDonation.setAmount(charityDonationDetails.getAmount());
        charityDonation.setInstitution(charityDonationDetails.getInstitution());
        charityDonation.setAddress(charityDonationDetails.getAddress());
        charityDonation.setPan(charityDonationDetails.getPan());
        charityDonation.setReceipts(charityDonationDetails.getReceipts());
        charityDonation.setRemarks(charityDonationDetails.getRemarks());

        CharityDonation updatedCharityDonation = charityDonationsRepository.save(charityDonation);
        return ResponseEntity.ok(updatedCharityDonation);
    }

    @DeleteMapping("/charityDonation/{id}")
    public ResponseEntity<Map<String, Boolean>> deleteCharityDonation(@PathVariable Long id) {
        CharityDonation charityDonation = charityDonationsRepository.findById(id)
                .orElseThrow(() -> new ResourceNotFoundException("Charity Donation with the given id not available" + id));
        charityDonationsRepository.delete(charityDonation);
        Map<String, Boolean> response = new HashMap<>();
        response.put("Deleted Successfully", Boolean.TRUE);
        return ResponseEntity.ok(response);
    }
}
