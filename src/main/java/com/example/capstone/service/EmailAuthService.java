package com.example.capstone.service;

import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.SimpleMailMessage;
import java.util.Map;
import java.util.Set;
import java.util.concurrent.ConcurrentHashMap;
import java.util.Random;

@Service
@RequiredArgsConstructor
public class EmailAuthService {

    private final JavaMailSender mailSender;

    // 인증번호 임시 저장소 (이메일, 인증번호)
    private final Map<String, String> authCodeStorage = new ConcurrentHashMap<>();
    private final Set<String> verifiedEmailStorage = ConcurrentHashMap.newKeySet();


    public void sendVerificationEmail(String email) {
        //대학 이메일 형식(.ac.kr)이 맞는지 검증
        if (!email.endsWith(".ac.kr")) {
            throw new IllegalArgumentException("대학 이메일계정(@*.ac.kr)만 인증이 가능합니다.");
        }

        // 6자리 랜덤 인증번호 생성
        String authCode = generateAuthCode();
        // 임시 저장소에 저장 (이미 요청한 적이 있다면 덮어쓰기)
        authCodeStorage.put(email, authCode);

        // 메일 내용인데 잘 가더라
        SimpleMailMessage message = new SimpleMailMessage();
        message.setTo(email);
        message.setSubject("[파티메이커] 대학 이메일 인증]");
        message.setText("본인 인증을 위해 아래의 6자리 인증번호를 앱에 입력해 주세요!\n\n"
                + "인증번호: [ " + authCode + " ]\n\n감사합니다.");

        mailSender.send(message);
    }

    // 2. 인증 이메일 코드 검증
    public boolean verifyEmailCode(String email, String code) {
        // 저장된 인증번호 가져오기
        String savedCode = authCodeStorage.get(email);

        if (savedCode == null) {
            throw new IllegalArgumentException("인증 요청 기록이 없거나 만료되었습니다.");
        }

        // 사용자가 입력한 코드와 서버가 보낸 코드가 일치하는지 확인
        if (savedCode.equals(code)) {
            authCodeStorage.remove(email); // 인증 성공 시 저장소에서 삭제
            verifiedEmailStorage.add(email);

            return true;
        }

        return false;
    }

    // 6자리 난수 생성기
    private String generateAuthCode() {
        Random random = new Random();
        int code = 100000 + random.nextInt(900000);
        return String.valueOf(code);
    }

    public boolean consumeVerifiedEmail(String email) {
        if (email == null) {
            return false;
        }

        return verifiedEmailStorage.remove(email);
    }
}