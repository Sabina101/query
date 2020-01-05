
select ma.MemberId,FirstName+' '+MiddleName+ ' '+LastName as Name ,acc_head as FDType ,a.Accountno ,
SavingAc as Interestcrto,ISNULL(MobileNo,'') AS MobileNo, Maturitydate,SUM(cr_amount) as Depositamount from Account a 
inner join Acc_Mem am on a.AccountNo=am.AccountNo
inner join MemberAccount ma on ma.Mem_ID=am.Mem_ID 
inner join Fixed_SavingAc fs on fs.AccountNo =a.AccountNo 
inner join Acc_Header ah on ah.Acc_ID=a.acc_id
inner join TBL_CHILD_VOUCHER cv on cv.L_ID=a.l_id
where acc_parentid=50 and Status=1 
group by cv.L_ID,MemberId,acc_head,FirstName,MiddleName,LastName,a.Accountno ,SavingAc ,MobileNo, Maturitydate
order by cast(memberid as int ) 