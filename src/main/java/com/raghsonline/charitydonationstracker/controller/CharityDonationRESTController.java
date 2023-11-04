package com.raghsonline.charitydonationstracker.controller;

import com.raghsonline.charitydonationstracker.entity.CharityDonation;
import com.raghsonline.charitydonationstracker.repository.CharityDonationRepository;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.web.bind.annotation.*;

import java.util.Date;
import java.util.List;
import java.util.Optional;

@RequestMapping("/api/CharityDonations")
@RestController
@AllArgsConstructor
@NoArgsConstructor
@Data
@Slf4j
public class CharityDonationRESTController {

    @Autowired
    CharityDonationRepository charityDonationsRepository;

    /*
        http://localhost:8080/api/CharityDonations/ --> Gets all the Donations
        http://localhost:8080/api/CharityDonations/123 --> Gets the details for the ID 123 (123 - Path Variable)
        http://localhost:8080/api/CharityDonations/FY2022-23 --> Gets all the Donations made in the FY 2022-23
        http://localhost:8080/api/CharityDonations/FY2022-23?PAN=APZR1033AH
            --> Gets all the Donations made in the FY 2022-23, for the matching PAN Number which is supplied as
            Request Parameter
        http://localhost:8080/api/CharityDonations/FY2022-23?Institute=LOTUS
            --> Gets all the Donations made in the FY 2022-23, for the matching Institute which is supplied as
            Request Parameter

        http://localhost:8080/api/CharityDonations/FY2022-23/LOTUS --> ?
        http://localhost:8080/api/CharityDonations/FY2022-23/APZR1033AH --> ?

        @GetMapping("/{year}/{institute}")
        @GetMapping("/{year}/{pan}")
     */
    @GetMapping()
    public List<CharityDonation> getAllCharityDonation() {
        log.info("Request URL - / received");
        List<CharityDonation> charityDonationList = charityDonationsRepository.findAll();
        log.debug("CharityDonationList (findAll):  " + charityDonationList);
        log.info("charityDonationList size : " + charityDonationList.size());
        return charityDonationList;
    }

    @GetMapping("/id/{id}")
    public Optional<CharityDonation> getCharityDonationForId(@PathVariable Long id) {
        log.info("Request URL - /{Id} received, id=[" + id + "]");
        Optional<CharityDonation> charityDonationList = charityDonationsRepository.findById(id);
        log.debug("CharityDonationList (findById):  " + charityDonationList);
        return charityDonationList;
    }

    @GetMapping("/pan/{pan}")
    public List<CharityDonation> getAllCharityDonationForPAN(@PathVariable String pan) {
        log.info("Request URL - /{PAN} received, pan=[" + pan + "]");
        List<CharityDonation> charityDonationList = charityDonationsRepository.findAllByPan(pan);
        log.debug("CharityDonationList (findAllByPAN):  " + charityDonationList);
        log.info("charityDonationList size : " + charityDonationList.size());
        return charityDonationList;
    }

    @GetMapping("/institution/{institution}")
    public List<CharityDonation> getAllCharityDonationForInstitution(@PathVariable("institution") String institution) {
        log.info("Request URL - /{Institution} received, institution=[" + institution + "]");
        List<CharityDonation> charityDonationList = charityDonationsRepository.findAllByInstitution(institution);
        log.debug("CharityDonationList (findAllByInstitution):  " + charityDonationList);
        log.info("charityDonationList size : " + charityDonationList.size());
        return charityDonationList;
    }

    @GetMapping("/financialYear/{financialYear}")
    public List<CharityDonation> getAllCharityDonationForFinancialYear(@PathVariable("financialYear") String financialYear) {
        log.info("Request URL - /{financialYear} received, financialYear=[" + financialYear + "]");
        List<CharityDonation> charityDonationList = charityDonationsRepository.findAllByFinancialYear(financialYear);
        log.debug("CharityDonationList (findAllByFinancialYear):  " + charityDonationList);
        log.info("charityDonationList size : " + charityDonationList.size());
        return charityDonationList;
    }

    @GetMapping("/receipts/{receipts}")
    public List<CharityDonation> getAllCharityDonationForReceipts(@PathVariable("receipts") String receipts) {
        log.info("Request URL - /{receipts} received, receipts=[" + receipts + "]");
        List<CharityDonation> charityDonationList = charityDonationsRepository.findAllByReceipts(receipts);
        log.debug("CharityDonationList (findAllByReceipts):  " + charityDonationList);
        log.info("charityDonationList size : " + charityDonationList.size());
        return charityDonationList;
    }

    @GetMapping("/address/{address}")
    public List<CharityDonation> getAllCharityDonationForAddress(@PathVariable("address") String address) {
        log.info("Request URL - /{address} received, address=[" + address + "]");
        List<CharityDonation> charityDonationList = charityDonationsRepository.findAllByAddress(address);
        log.debug("CharityDonationList (findAllByAddress):  " + charityDonationList);
        log.info("charityDonationList size : " + charityDonationList.size());
        return charityDonationList;
    }

    @GetMapping("/{fromDate}/{toDate}")
    public List<CharityDonation> getAllCharityDonationForDate(
            @PathVariable("fromDate") @DateTimeFormat(iso = DateTimeFormat.ISO.DATE) Date fromDate,
            @PathVariable("toDate") @DateTimeFormat(iso = DateTimeFormat.ISO.DATE) Date toDate) {
        log.info("Request URL - /{fromDate} received, fromDate=[" + fromDate + "]" + " /{fromDate} received, toDate=[" + toDate + "]");
        List<CharityDonation> charityDonationList = charityDonationsRepository.findByDateBetween(fromDate, toDate);
        log.debug("CharityDonationList (findByDateBetween):  " + charityDonationList);
        log.info("charityDonationList size : " + charityDonationList.size());
        return charityDonationList;
    }

    @PostMapping()
    public CharityDonation createCharityDonation(@RequestBody CharityDonation charityDonation) {
        log.info("Getting charity donation values: " + charityDonation);
        return charityDonationsRepository.save(charityDonation);
    }

    @DeleteMapping("/{id}")
    public void deleteCharityDonation(@PathVariable Long id) {
        charityDonationsRepository.deleteById(id);
    }


}