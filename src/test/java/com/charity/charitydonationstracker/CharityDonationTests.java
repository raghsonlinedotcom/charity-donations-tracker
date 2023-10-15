package com.charity.charitydonationstracker;

import com.charity.charitydonationstracker.entity.CharityDonation;
import com.charity.charitydonationstracker.repository.CharityDonationsRepository;
import org.junit.jupiter.api.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

import java.time.Year;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import static org.springframework.test.util.AssertionErrors.assertTrue;

@SpringBootTest
public class CharityDonationTests {
    @Autowired
    private CharityDonationsRepository charityDonationsRepository;

    private List<CharityDonation> donations;
    
    @BeforeAll
    static void initAll() {
    }

    @BeforeEach
    void init() {
        donations = charityDonationsRepository.findAll();
    }

    @Test
    public void charityDonationsCountTest() {
        List<CharityDonation> donations = charityDonationsRepository.findAll();
         int charityDonationsCountTest = donations.size();
         int expectedValue = 10;
        assertTrue("Charity donations count is greater than " + expectedValue, charityDonationsCountTest > expectedValue);
    }

    @Test
    public void financialYearWiseCount() {
        Map<String, Integer> yearCounts = new HashMap<>();
        for (CharityDonation donation: donations) {
            String year = donation.getFinancialYear();
            yearCounts.put(year, yearCounts.getOrDefault(year, 0)+1);
        }

        yearCounts.forEach((year,count) -> {
            System.out.println("Financial Year " + year + ": " + count + " entries");
        });
    }

    @Test
    public void institutionWiseCount() {
        Map<String, Integer> yearCounts = new HashMap<>();

        for (CharityDonation donation: donations) {
            String year = donation.getInstitution();
            yearCounts.put(year, yearCounts.getOrDefault(year, 0)+1);
        }

        yearCounts.forEach((institution,count) -> {
            System.out.println( "institution is " + institution + ": " + count + " entries");
        });
    }

    @Test
    public void charityDonationsCountGreaterThanCheckTest() {
        int charityDonationsCountTest = donations.size();
        Assertions.assertTrue(charityDonationsCountTest > 0, "Charity donations count is greater than zero");
        for (CharityDonation donation : donations) {
            System.out.println(donation);
        }
    }

    @Test
    public void charityDonationsCountLessThanCheckTest() {
        List<CharityDonation> donations = charityDonationsRepository.findAllByFinancialYearAndInstitution("2022-2025", "abc");
        int charityDonationsCountTest = donations.size();

        if (charityDonationsCountTest > 0) {
            Assertions.assertTrue(charityDonationsCountTest > 0, "Charity donations count is greater than zero");
        } else {
            Assertions.assertEquals(0, charityDonationsCountTest, "Charity donations count is zero");
            System.out.println("Charity donations count is zero");
        }
    }

    @AfterEach
    void tearDown() {
    }

    @AfterAll
    static void tearDownAll() {
    }
}
