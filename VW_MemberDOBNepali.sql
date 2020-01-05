USE [MaTest]
GO

/****** Object:  View [dbo].[VW_MemberDOBNepali]    Script Date: 01/05/2020 09:33:14 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO




ALTER view [dbo].[VW_MemberDOBNepali] as
select Mem_ID,MemberId,(select fullname from dbo.funFORMAT_NAME(FirstName,MiddleName,LastName)) as FullName
,case when LEN(MobileNo)>=10 and CHARINDEX(',',MobileNo)<=0 
	then RIGHT(MobileNo,10) 
	else 
		case when LEN(MobileNo)>=10 and CHARINDEX(',',MobileNo)>0 
		then
			Right(LEFT(MobileNo,(charindex(',',MobileNo)-1)),10)
		else
		  ''
		end

 end  as MobileNO
,BirthDate,NepaliDate as BirthDateNepali,LEFT(NepaliDate,4) as YearNepali,SUBSTRING(NepaliDate,6,2) as MonthNepali,SUBSTRING(NepaliDate,9,2) as DayNepali from MemberAccount ma
left join tbl_NepaliDate TND on ma.BirthDate=TND.EnglishDate
where TND.NepaliDate is not null or TND.NepaliDate!=''

union all 

select ma.Mem_ID,MemberId,Child_Name+'('+'Child'+')'  as FullName,
case when LEN(MobileNo)>=10 and CHARINDEX(',',MobileNo)<=0 
	then RIGHT(MobileNo,10) 
	else 
		case when LEN(MobileNo)>=10 and CHARINDEX(',',MobileNo)>0 
		then
			Right(LEFT(MobileNo,(charindex(',',MobileNo)-1)),10)
		else
		  ''
		end

 end  as MobileNO,Child_Dob  as BirthDate ,NepaliDate as BirthDateNepali,LEFT(NepaliDate,4) as YearNepali,SUBSTRING(NepaliDate,6,2) as MonthNepali,SUBSTRING(NepaliDate,9,2) as DayNepali from MemberAccount ma 
inner join ChildrenDetail  cd on ma.Mem_ID=cd.mem_id 
inner join Acc_Mem am on am.AccountNo=cd.AccountNo 
left join tbl_NepaliDate TND on cd.Child_Dob =TND.EnglishDate
where Status=1 and TND.NepaliDate is not null or TND.NepaliDate!=''



GO


