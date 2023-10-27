package com.raghsonline.charitydonationstracker.repository;

import com.raghsonline.charitydonationstracker.entity.CharityDonation;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.Date;
import java.util.List;
import java.util.Optional;

@Repository
public interface CharityDonationRepository extends JpaRepository<CharityDonation, Long> {

    List<CharityDonation> findAllByFinancialYear(String financialYear);

    List<CharityDonation> findAllByFinancialYearAndInstitution(String financialYear, String institution);

    List<CharityDonation> findAllByInstitution(String institution);

    List<CharityDonation> findAllByPan(String pan);

    Optional<CharityDonation> findByPan(String pan);

    List<CharityDonation> findByFinancialYear(String financialYear);

    List<CharityDonation> findAllByReceipts(String receipts);

    List<CharityDonation> findAllByAddress(String address);

    List<CharityDonation> findByDate(Date date);

    List<CharityDonation> findByDateBetween(Date fromDate, Date toDate);

}
