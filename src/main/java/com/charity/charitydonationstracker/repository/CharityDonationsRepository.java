package com.charity.charitydonationstracker.repository;

import com.charity.charitydonationstracker.entity.CharityDonation;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.Date;
import java.util.List;
import java.util.Optional;

@Repository
public interface CharityDonationsRepository extends JpaRepository<CharityDonation, Long> {

    List<CharityDonation> findAllByFinancialYear(String financialYear);

    List<CharityDonation> findAllByFinancialYearAndInstitution(String financialYear, String institution);

    List<CharityDonation> findByInstitution(String institution);

    Optional<CharityDonation> findByPan(String pan);

    List<CharityDonation> findByFinancialYear(String financialYear);

    List<CharityDonation> findByReceipts(String Receipts);

    List<CharityDonation> findByAddress(String address);

    List<CharityDonation> findByDate(Date date);

    List<CharityDonation> findByDateBetween(Date fromDate, Date toDate);

}
