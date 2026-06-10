    package com.example.capstone.repository;

    import com.example.capstone.entity.PartyRole;
    import org.springframework.data.jpa.repository.JpaRepository;
    import org.springframework.data.jpa.repository.Query;
    import org.springframework.stereotype.Repository;

    import java.util.List;

    @Repository
    public interface PartyRoleRepository extends JpaRepository<PartyRole,Long> {
        @Query("SELECT DISTINCT p.roleName FROM PartyRole p")
        List<String> findDistinctRoleNames();
    }

