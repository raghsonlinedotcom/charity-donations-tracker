package com.raghsonline.charitydonationstracker;

import com.raghsonline.charitydonationstracker.entity.CharityDonation;
import com.raghsonline.charitydonationstracker.repository.CharityDonationRepository;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.CommandLineRunner;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

import java.util.List;

@SpringBootApplication
@Slf4j
public class CharityDonationsTrackerApplication implements CommandLineRunner
{
	@Autowired
	CharityDonationRepository repository;

	public static void main(String[] args) {
		SpringApplication.run(CharityDonationsTrackerApplication.class, args);
		log.info("CharityDonationsTrackerApplication - main()");
	}

	@Override
	public void run(String... args) throws Exception {
		log.info("CharityDonationsTrackerApplication - run()");
		List<CharityDonation> charityDonationList = repository.findAll();
		log.info("charityDonationList - size : " + charityDonationList.size());

		log.info("===============");
		String financialYear = "2023-2024";
		List<CharityDonation> charityDonationListForYear = repository.findAllByFinancialYear(financialYear);
		log.info("Financial Year : " + financialYear);
		log.info("charityDonationList for the financialYear - size : " + charityDonationListForYear.size());

		log.info("===============");
		var INSERT_SQL_BEGIN = "INSERT INTO charity_donation (financialYear, date, receipt, amount, institution, address, pan, Receipts, remarks) VALUES (";
		charityDonationListForYear.stream().forEach(x -> System.out.println(INSERT_SQL_BEGIN +
				"'" + x.getFinancialYear()
				+ "', '" + x.getDate().toString().substring(0, 10)
				+ "', '" + x.getReceipt()
				+ "', '" + x.getAmount()
				+ "', '" + x.getInstitution()
				+ "', '" + x.getAddress()
				+ "', '" + x.getPan()
				+ "', '" + x.getReceipts()
				+ "', '" + x.getRemarks()
				+ "');"));

	}
}
