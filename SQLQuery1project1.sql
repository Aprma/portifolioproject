Select*
from [Portfolio-Project1]..['Covid-Deaths$']
order by 3,4

--Select*
--from [Portfolio-Project1]..['Covid-Vaccination$']
--order by 3,4

select Location, Date, Population, Total_cases, Total_deaths, (total_deaths/total_cases)*100 as Deathpercentage
from [Portfolio-Project1]..['Covid-Deaths$']
where location like '%states%'
order by 3,4

--looking at countries with highest infection rate

select Location, Population, max(Total_cases) as HighestInfectedcount, max((total_cases/population))*100 as percentageofInfected 
from [Portfolio-Project1]..['Covid-Deaths$']

group by location, population 
order by HighestInfectedcount desc

--showing countinents with highest death count per population
select continent, max(cast(total_deaths as int)) as Highestdeathcount
from [Portfolio-Project1]..['Covid-Deaths$']
where continent is not null
group by continent 
order by Highestdeathcount desc


--global numbers by date 

select date, sum(new_cases) as Newcases, sum(cast(new_deaths as int)) as Newdeaths, sum(cast(new_deaths as int))/sum(new_cases)*100 as percentageofdeathsperday
from [Portfolio-Project1]..['Covid-Deaths$']
where continent is not null
group by date 
order by 1, 2


--Looking at total population who took vaccination per country/continent 

select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations,
sum(convert(int, vac.new_vaccinations)) over(partition by dea.location order by dea.location, dea.date)
as Rollingpeoplevaccinated
from [Portfolio-Project1]..['Covid-Deaths$'] dea
join [Portfolio-Project1]..['Covid-Vaccination$'] vac
on dea.location = vac.location
and dea.date = vac.date
where dea.continent is not null
order by 2, 3