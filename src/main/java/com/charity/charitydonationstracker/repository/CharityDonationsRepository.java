package com.charity.charitydonationstracker.repository;

import com.charity.charitydonationstracker.entity.CharityDonation;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface CharityDonationsRepository extends JpaRepository<CharityDonation, Long> {

    public List<CharityDonation> findAllByFinancialYear(String financialYear);

    public List<CharityDonation> findAllByFinancialYearAndInstitution(String financialYear, String institution);
}
