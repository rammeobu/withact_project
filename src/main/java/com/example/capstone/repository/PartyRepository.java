package com.example.capstone.repository;

import com.example.capstone.entity.Party;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;


@Repository
public interface PartyRepository extends JpaRepository<Party, Long> {

}
