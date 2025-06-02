# 5-yeosa-ongi-cloud

5조 여사팀 "온기" 서비스 Cloud Terraform 레포지토리입니다.
---
```
v2-3-tier/
├── env/                            # 환경별 인프라 정의
│   ├── dev/                        # 개발 환경
│   │   ├── main.tf                 # 모듈 호출 및 구성
│   │   ├── provider.tf             # GCP provider 설정
│   │   ├── terraform.tfvars        # 변수 값 정의
│   │   ├── variables.tf            # 환경에서 사용하는 변수 선언
│   │   ├── backend-config.hcl      # (Git 제외 권장) 상태 저장소 설정
│   │   └── scripts/                # 초기화, 배포 스크립트 등
│   ├── prod/                       # 운영 환경 (dev와 동일 구조)
│
├── modules/                        # 공통 인프라 구성 모듈
│   └── gcp/                        # GCP 관련 모듈 모음
│       ├── vpc/                    # VPC, Subnet 정의
│       ├── firewall/               # 방화벽 규칙 설정
│       ├── storage/                # GCS 버킷 관련 모듈
│       ├── openvpn/                # VPN 서버 인스턴스 구성
│       ├── alb/                    # Application Load Balancer 설정
│       ├── cdn/                    # GCS + BackendBucket + CDN 구성
│       ├── dns/                    # Cloud DNS A레코드, zone 설정
│       ├── backend-instance/       # 백엔드 인스턴스 템플릿
│       ├── backend-service/        # 백엔드 서비스용 LB/MIG 등
│       ├── ai-instance/            # AI 서버 인스턴스 (FastAPI 등)
│       ├── nat/                    # Cloud NAT 구성
│       ├── db/                     # Cloud SQL / MySQL 설정
│       │   ├── peering.tf          # VPC Peering 구성
│       │   ├── replica.tf          # Read Replica 구성
│       └── mig/                    # Managed Instance Group (MIG) 관련
│
└── .terraform.lock.hcl            # Terraform provider 버전 잠금 파일

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
