lang : [Kor]() | [Eng](https://github.com/namjugood/project_Eco/blob/6d4ae53a9e59f3831e6d885fe9936fa269661599/README.md)

# Project : ECO
![count](https://img.shields.io/github/languages/count/namjugood/project_Eco)
![top](https://img.shields.io/github/languages/top/namjugood/project_Eco)
![repo-size](https://img.shields.io/github/repo-size/namjugood/project_Eco)
![commit](https://img.shields.io/github/commit-activity/w/namjugood/project_Eco)
![last-commit](https://img.shields.io/github/last-commit/namjugood/project_Eco)

## 1. 프로젝트 정의
1. 본 프로젝트는 __"음악 스트리밍 서비스 웹페이지"__입니다.
	- 벤치마킹: FLO(https://www.music-flo.com/)  
	- 자세한 내용은 아래의 링크를 통해 문서로 확인하실 수 있습니다(LNG:KOR & ENG)
	
		|기능정의 및 구현분배|[Link(KOR)](https://docs.google.com/spreadsheets/d/1GkkUYpng9CMe0P4aIt9WKx0CFHZy1EF6HUVFZVcUqy4/edit?usp=sharing)|
		|---|---|
		|프리젠테이션 파일|[Link(ENG+KOR)](https://drive.google.com/file/d/1TQZtdcUhs6oai4WrKwn95tfxlqUOmw4f/view?usp=sharing)|
2. 개발인원

	|<img width="50" src="https://avatars.githubusercontent.com/u/77426494?s=64&v=4"/></br>[MW.Kim]()|<img width="50" src="https://avatars.githubusercontent.com/u/80030590?s=120&v=4"/></br>[NJ Lee](https://https://github.com/namjugood)|<img width="50" src="https://avatars.githubusercontent.com/u/79358518?s=64&v=4"/></br>[JinGoon-Kim](https://github.com/JinGoon-Kim)|<img width="50" src="https://avatars0.githubusercontent.com/u/28638438?s=120&v=4"/></br>[junohera](https://https://github.com/Junohera)|<img width="50" src="https://avatars.githubusercontent.com/u/81345782?s=64&v=4"/></br>[mamemin](https://github.com/mamemin)|
	|:---:|:---:|:---:|:---:|:---:|

---
## 2. 주의
- 프로젝트에 사용된 모든 소스는 __<U>"비상업적용도"</U>__로 사용되었습니다.
- __<U>본 소스에 대한 모든 권한은 "FLO"에 있으며, FLO의 허락없이 유포 및 상업적용도로 사용시 법적인 제재를 받을 수 있습니다</U>__
---
## 3. 개발환경
|OS|Windows 10|
|:---|:---|
|Browser|Chrome|
|WAS|Apache Tomcat 9.0|
|DBMS|Oracle XE 11 6g|
|Language|Java Platform8, JSP & Servlet|
|WEB|Spring Framework Gradle|
|Open Source|HTML5, CSS/CSS3, JavaScript, cos, ojdbc6, <br>JSTL, JavaScript, jQuery, myBatis, Lombok,Devtool etc.|
|IDE Tool|Eclipse Java EE IDE|
---
## 4. 핵심 구현기술
1. 멤버십 기능
- 이 기능은 __"유료회원"__과 "무료회원"에 제공되는 서비스를 분할하기 위함입니다.
- 무료회원은 음악 전체를 들을 수 없으며, 유료회원은 멤버십 만료기간까지 제한없이 음악을 들을 수 있습니다.

![image](https://user-images.githubusercontent.com/80030590/112624331-d8389400-8e70-11eb-85b2-79623fe4ddbe.png)
<br>

2. 음악 플레이어
- 데이터의 흐름은 아래의 색깔선 방향으로 움직입니다.

![image](https://user-images.githubusercontent.com/80030590/112624274-bdfeb600-8e70-11eb-83dd-ef9a6206773a.png)










