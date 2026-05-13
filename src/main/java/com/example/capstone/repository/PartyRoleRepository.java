    package com.example.capstone.repository;

    import com.example.capstone.entity.PartyRole;
    import org.springframework.data.jpa.repository.JpaRepository;
    import org.springframework.stereotype.Repository;

    @Repository
    public interface PartyRoleRepository extends JpaRepository<PartyRole,Long> {
    }
