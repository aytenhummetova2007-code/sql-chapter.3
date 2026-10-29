Explanation of SQL Queries and Challenges

1. Ən çətin sorğu

Mənə ən çətin gələn sorğu 3.15a oldu: “Brooklyn”-dəki hər filialda hesabı olan müştəriləri tapmaq. SQL-də “hər biri üçün” (bölmə, division) əməliyyatı üçün hazır açar söz yoxdur. Bunu iki yolla həll etmək olar: ya not exists ilə except-i birlikdə işlətmək, ya da say müqayisəsi ilə. Mən say müqayisəsini seçdim. Müştərinin hesabı olduğu fərqli Brooklyn filiallarının sayı having count(distinct b.branch_name) ilə hesablanır və Brooklyn-dəki bütün filialların sayı ilə müqayisə edilir. Burada vacib nüans var: say yalnız Brooklyn filiallarına görə hesablanmalıdır, əks halda başqa şəhərdəki hesablar nəticəni pozar. Buna görə where b.branch_city = 'Brooklyn' şərtini əlavə etdim.

2. Alt sorğu (subquery) istifadə etdiyim sorğular
Alt sorğunu bir neçə yerdə istifadə etdim. 3.25-də Philosophy departamentinin büdcəsini (select budget from department where dept_name = 'Philosophy') alt sorğusu ilə tapıb digər departamentlərin büdcəsi ilə müqayisə etdim. 3.11b-də not in (select ID from takes where year < 2017) ilə 2017-dən əvvəl kurs götürənləri çıxardım. 3.35-də isə with daxilində hər bölmənin tələbə sayını hesablayıb where num = (select max(num) ...) alt sorğusu ilə maksimumu seçdim.


3. JOIN nümunəsi
3.24 JOIN-in yaxşı nümunəsidir. Məlumat üç cədvələ paylanıb: tələbənin departamenti student-də, müəllimin departamenti instructor-da, onların əlaqəsi isə advisor-dadır. Ona görə student-i advisor ilə s.ID = a.s_ID üzrə, advisor-u instructor ilə a.i_ID = i.ID üzrə birləşdirdim. Sonda s.dept_name = 'Accounting' və i.dept_name = 'Physics' şərtləri ilə nəticəni süzdüm. Beləliklə bir sorğuda hər iki departament şərtini yoxlaya bildim.


4. Qarşılaşdığım problem və həlli
İlk problem cədvəllərin olmaması idi. Sorğunu işlədəndə relation "advisor" does not exist xətası çıxdı, çünki bazada cədvəl yaradılmamışdı. Həll olaraq sxemi create table ilə qurdum və test məlumatlarını insert etdim. Sonra skripti təkrar işlətdiyim üçün relation already exists və duplicate key xətaları çıxdı. Bunu drop table if exists və truncate ilə köhnə məlumatı təmizləyib insert-ləri yalnız bir dəfə işlətməklə həll etdim. Bundan öyrəndim ki, skriptləri ardıcıl işlətmək və xəta olanda əvvəlcə bazanın vəziyyətini yoxlamaq lazımdır.
Ayrıca 3.31–3.32-də teaches ilə takes-i birləşdirəndə yalnız course_id üzrə birləşdirmək səhvdir. Bölməni dəqiq təyin etmək üçün course_id, sec_id, semester və year birlikdə yoxlanmalıdır. Bunu başa düşəndən sonra sorğular düzgün işlədi.
