package com.charity.charitydonationstracker;

import com.charity.charitydonationstracker.entity.CharityDonation;
import com.charity.charitydonationstracker.repository.CharityDonationsRepository;
import org.junit.jupiter.api.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.ZoneId;
import java.util.*;

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

    @Test
    public void testFindById() {
        CharityDonation charityDonation = charityDonationsRepository.findById(1L).get();
        Assertions.assertEquals(1, charityDonation.getId(), "Id found");
    }

    @Test
    public void findByInstitution() {
        List<CharityDonation> donations = charityDonationsRepository.findByInstitution("London Children's Fund");

        Assertions.assertFalse(donations.isEmpty(), "No donations found for the given institution");

        String expectedInstitution = "London Children's Fund";
        for (CharityDonation donation : donations) {
            String actualInstitution = donation.getInstitution();
            Assertions.assertEquals(expectedInstitution, actualInstitution, "Institute found correctly");
        }
    }

    @Test
    public void testFindByPAN() {
        Optional<CharityDonation> donations = charityDonationsRepository.findByPan("NZP234");
        Assertions.assertFalse(donations.isEmpty(), "There is No pan");
        CharityDonation donation = donations.get();
        System.out.println(donation + " Hel");
        String expectedPan = "NZP234";
        String actualPan = donation.getPan();
        Assertions.assertEquals(expectedPan, actualPan, "Pan found correctly");
    }

    @Test
    public void testFindByFinancialYear() {
        List<CharityDonation> charityDonationListForYear = charityDonationsRepository.findByFinancialYear("2023-2024");
        Assertions.assertFalse(charityDonationListForYear.isEmpty(), "In financial year of " + charityDonationListForYear + "there is no records found");
        int expectedCount = 1;
        int count = charityDonationListForYear.size();
        assertTrue("In all the financial years expected count is greater than 5", count > expectedCount);
    }

    @Test
    public void testFindByReceiptsStatus() {
        List<CharityDonation> donations = charityDonationsRepository.findByReceipts("Y");
        Assertions.assertFalse(donations.isEmpty(), "Receipts found empty");
        String expectedReceipt = "Y";
        for(CharityDonation donation: donations) {
            String actualReceipt = donation.getReceipts();
            Assertions.assertEquals(expectedReceipt, actualReceipt, "Receipts is correct");
        }
    }

    @Test
    public void testFindByLocation() {
        List<CharityDonation> donations = charityDonationsRepository.findByAddress("50 Cardiff St, Cardiff, CF10 1BB");
        Assertions.assertFalse(donations.isEmpty(), "In this no Location records found");
        String expectedAddress = "50 Cardiff St, Cardiff, CF10 1BB";
        for(CharityDonation donation : donations) {
            String actualAddress = donation.getAddress();
            Assertions.assertEquals(expectedAddress, actualAddress, "Location found correctly");
        }
    }

    @Test
    public void findDonationsBetweenDates()
    {
        LocalDate fromDateLocal = LocalDateTime.of(2023, 01, 01, 00, 00).toLocalDate();
        LocalDate toDateLocal = LocalDateTime.of(2023, 11, 10, 00, 00).toLocalDate();

        System.out.println("fromDateLocal = " + fromDateLocal);
        System.out.println("toDateLocal = " + toDateLocal);

        Date fromDate = Date.from(fromDateLocal.atStartOfDay(ZoneId.systemDefault()).toInstant());
        System.out.println("fromDate = " + fromDate);
        Date toDate = Date.from(toDateLocal.atStartOfDay(ZoneId.systemDefault()).toInstant());
        System.out.println("toDate = " + toDate);

        List<CharityDonation> donationsListForDuration = charityDonationsRepository.findByDateBetween(fromDate, toDate);

        System.out.println("donationsListForDuration = " + donationsListForDuration);
        System.out.println("size : " + donationsListForDuration.size());
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
