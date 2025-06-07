# 5-yeosa-ongi-cloud

5조 여사팀 "온기" 서비스 Cloud Terraform 레포지토리입니다.
---
```
5-YEOSA-ONGI-CLOUD/
├── v1-single-instance/
│   ├── env/                          # 환경별 인프라 구성
│   │   ├── dev/                      # 개발 환경용 main.tf, tfvars 등
│   │   └── prod/                     # 운영 환경용 main.tf, tfvars 등
│   │
│   ├── modules/                     # GCP 단일 인스턴스용 공통 모듈
│   │   ├── aws/                     # (예비용 or 공유 자원)
│   │   ├── gcp/
│   │   │   ├── cdn/                 # GCS + CDN 설정 (정적 파일 서빙용)
│   │   │   ├── firewall/            # 방화벽 설정 (SSH, HTTP 등 포트 허용)
│   │   │   ├── instance/            # 단일 GCE 인스턴스 생성 (VM 구성)
│   │   │   ├── snapshot_policy/     # 디스크 스냅샷 정책 관리
│   │   │   └── vpc/         
│
├── v2-3-tier/                       # 현재 사용 중인 3-Tier 아키텍처 환경별 구성
│   ├── env/                         # 환경별 tfvars, backend 설정
│   │   ├── dev/
│   │   └── prod/
│   │
│   ├── scripts/                     # GCE startup script 등 셸 스크립트
│   ├── backend.tf                   # Terraform backend 설정
│   ├── main.tf                      # 환경별 module 호출
│   ├── provider.tf                  # GCP provider 정의
│   ├── terraform.tfvars             # 주요 변수 정의
│   └── variables.tf                 # input variables 선언
│
├── modules/
│   ├── gcp/
│   │   ├── vpc/                     # VPC, 서브넷, 라우팅 설정
│   │   ├── firewall/                # 방화벽 규칙 정의
│   │   ├── nat/                     # NAT 게이트웨이 구성
│   │   ├── instance/                # 단일 인스턴스 (GCE) 구성
│   │   ├── mig/                     # Managed Instance Group 구성
│   │   ├── backend-instance/        # 백엔드 서버 GCE 인스턴스 (템플릿 기반)
│   │   ├── backend-service/         # 백엔드용 Load Balancer Backend Service
│   │   ├── db/                      # Cloud SQL DB (primary, replica, peering)
│   │   ├── openvpn/                 # OpenVPN 인스턴스 구성
│   │   ├── cdn, alb/                # GCS 기반 CDN + Load Balancer 구성
│   │   ├── ai-instance/             # AI 모델용 서버 인스턴스
│   │   ├── ai-service/              # AI 백엔드 서비스용 LB 설정
│   │   ├── storage/                 # GCS 및 IAM 설정
│   │   ├── dns/                     # Cloud DNS 레코드 정의
│   │   └── shared/                  # 공통 변수 또는 재사용 모듈
│
│
└── .gitignore
```

## v1-single-instance
![5-ys-Architecture-단일 인스턴스 설계 drawio (2)](https://github.com/user-attachments/assets/d02e3221-b7c4-474d-b81f-53ec37267f6c)

## v2-3-tier
![5-ys-Architecture-PNG 내보내기 창 drawio (1)](https://github.com/user-attachments/assets/5f198a10-ffe0-40a4-96d3-3ce92e39b73e)


## Commit Convention
| 머릿말            | 설명 |
|------------------|------|
| `feat`           | 새로운 기능 추가 |
| `fix`            | 버그 수정 |
| `design`         | CSS 등 사용자 UI 디자인 변경 |
| `!BREAKING CHANGE` | 커다란 API 변경의 경우 |
| `!HOTFIX`        | 코드 포맷 변경, 세미콜론 누락 등 (코드 수정은 없는 경우) |
| `refactor`       | 프로덕션 코드 리팩토링 |
| `comment`        | 필요한 주석 추가 및 변경 |
| `docs`           | 문서 수정 |
| `test`           | 테스트 추가, 테스트 리팩토링 (프로덕션 코드 변경 X) |
| `setting`        | 패키지 설치, 개발 설정 관련 변경 |
| `chore`          | 빌드, 테스트 업데이트, 패키지 매니저 설정 (프로덕션 코드 변경 X) |
| `rename`         | 파일 혹은 폴더명을 수정하거나 옮기는 작업 |
| `remove`         | 파일을 삭제하는 작업만 수행한 경우 |

## Commit Convention Detail
* <타입>: <제목> - <이슈번호> 의 형식으로 제목을 아래 공백줄에 작성
* 제목은 50자 이내 / 변경사항이 "무엇"인지 명확히 작성 / 끝에 마침표 금지
* 예) feat: 로그인 기능 추가 - #2
* 본문(구체적인 내용)을 아랫줄에 작성
* 여러 줄의 메시지를 작성할 땐 "-"로 구분 (한 줄은 72자 이내)
* 제목과 본문은 한 줄 띄워 분리

---
## Branch 전략
* main(prod)
* dev
* hotfix
* feature (issue 생성 후 브랜치 만들 때)
  ex) feat/#{이슈 번호}, fix/#{이슈 번호} etc...
