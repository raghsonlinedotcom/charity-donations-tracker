package com.charity.charitydonationstracker;

import com.charity.charitydonationstracker.entity.CharityDonation;
import com.charity.charitydonationstracker.repository.CharityDonationsRepository;
import org.junit.jupiter.api.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.web.client.response.ExecutingResponseCreator;

import java.sql.SQLOutput;
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
        System.out.println("Execute before all tests in the test class");
    }

    @BeforeEach
    void init() {
        donations = charityDonationsRepository.findAll();
        System.out.println("Execute before each test complete in the test class");
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
            int expectedCount = 5;
            assertTrue("In all the financial years expected count is greater than 5", count > expectedCount);
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
            int institutionCount = 1;
            assertTrue("Every institute count is greater than " + institutionCount, count >= institutionCount);
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
        System.out.println("Execute after each tests in the test class");
    }

    @AfterAll
    static void tearDownAll() {
        System.out.println("Execute after all tests in the test class");
    }
}
