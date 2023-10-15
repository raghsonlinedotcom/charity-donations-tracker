package com.charity.charitydonationstracker.entity;

import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Column;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.springframework.web.bind.annotation.RestController;


import java.util.Date;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Entity
@RestController
@Table(name = "charity_donation")
public class CharityDonation {
    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    private Long id;
    @Column(name = "financialYear")
    private String financialYear;
    private Date date;
    private String receipt;
    private double amount;
    private String institution;
    private String address;
    private String pan;
    private String Receipts;
    private String remarks;
}
