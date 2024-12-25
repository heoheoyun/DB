1. �� ��ǳ�� �߻� ��¥�� ��ǳ �̸� ��ȸ
select tyname as ��ǳ�̸�, cdate as �߻���
from typhoon;

2. �� ������ �� ���� �ݾװ� ���� ��ȣ ��ȸ
select regno as ������ȣ, sum(prodmg) as �����رݾ�
from impact
group by regno;

3. �� ��ǳ�� �߻� �ϼ� ��ȸ
select tyno as ��ǳ��ȣ, tyname as ��ǳ�̸�,
       (edate - cdate) as �߻��ϼ�
from typhoon
where edate is not null;

4. Ư�� ��ǳ�� ������ ���� ���� �ݾ��� ��ȸ (��: tyno�� 1�� ��ǳ)
select tyno as ��ǳ��ȣ, sum(misperson + inperson + evaperson) as �������ڼ�, sum(prodmg) as �����رݾ�
from impact
where tyno = 1
group by tyno;

5. �� ��ǳ ��޺� ��ǳ ���� ��ȸ
select rno as ��ǳ��޹�ȣ, 
       count(*) as ��ǳ����
from typhoon
group by rno;

1. ��ǳ�� ���� ���� ��ȸ
SELECT t.tyname AS ��ǳ�̸�, 
       (i.misperson + i.inperson + i.evaperson) AS �������ڼ�
FROM Typhoon t
INNER JOIN Impact i ON t.tyno = i.tyno;

2. ������ ��ǳ �߻� �� ��ȸ
SELECT r.regname AS ������, 
       COUNT(t.tyno) AS ��ǳ�߻���
FROM Region r
LEFT OUTER JOIN Typhoon t ON r.regno = t.rno
GROUP BY r.regname;

3. �� ��ǳ�� ������ �� �� ���� ���� ��ȸ
SELECT t.tyname AS ��ǳ�̸�, 
       i.misperson + i.inperson + i.evaperson AS �������ڼ�, 
       r.regname AS ������
FROM Typhoon t
INNER JOIN Impact i ON t.tyno = i.tyno
LEFT OUTER JOIN Region r ON i.regno = r.regno;

1. Ư�� ��ǳ�� ������ ���� ���� ���� ���� ��ȸ
SELECT r.regname AS ������
FROM Region r
WHERE r.regno IN (
    SELECT i.regno
    FROM Impact i
    WHERE i.tyno = (
        SELECT t.tyno
        FROM Typhoon t
        WHERE t.tyname = '����'  -- ���⼭ 'Ư�� ��ǳ �̸�'�� ���� ��ǳ �̸����� ����
    )
);

2. ���رݾ��� ���� ���� ��ǳ�� �̸� ��ȸ
SELECT t.tyname AS ��ǳ�̸�, r.regname AS ������
FROM Typhoon t
JOIN Impact i ON t.tyno = i.tyno
JOIN Region r ON i.regno = r.regno
WHERE i.prodmg IN (
    SELECT MAX(prodmg)
    FROM Impact
);

3. �� ��ǳ�� ������ ���� ��ü ��պ��� ���� ��ǳ ��ȸ
SELECT t.tyname AS ��ǳ�̸�
FROM Typhoon t
WHERE (
    SELECT SUM(i.misperson + i.inperson + i.evaperson)
    FROM Impact i
    WHERE i.tyno = t.tyno
) > (
    SELECT AVG(misperson + inperson + evaperson) 
    FROM Impact
);