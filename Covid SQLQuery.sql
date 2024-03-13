--COVID DATA

--Table 1
select *
from CovidDeaths
order by 3,4

--Table 2
select *
from CovidVaccinations
order by 3,4

--SELECT DATA WE ARE GOING TO BE USING
select location, date, total_cases, new_cases, total_deaths, population
from CovidDeaths
order by 1,2 desc

--LOOKING AT TOTAL CASES VS TOTAL DEATHS
--LIKELIHOOD OF DYING OF COVID PER COUNTRY
select location, sum(new_cases) as TotalCases, sum(new_deaths) as TotalDeaths, sum(total_deaths)/sum(total_cases)*100 as DeathPercentage
from CovidDeaths
where continent is not null
group by location
order by 4 desc

--LIKELIHOOD OF A NIGERIAN DYING OF COVID
select location, date, total_cases, total_deaths, (total_deaths/total_cases)*100 as DeathPercentage
from CovidDeaths
where location = 'Nigeria'
order by 2 desc

--LOOKING AT TOTAL CASES VS POPULATION
--COUNTRIES WITH HIGHEST INFECTION RATE
select location, population, max(total_cases) as HighestInfectionCount, max((total_cases/population))*100 as PercentPopulationInfected
from CovidDeaths
group by location, population
order by 4 desc

--INFECTION RATE IN NIGERIA
select location, date, population, total_cases, (total_cases/population)*100 as PercentPopulationInfected
from CovidDeaths
where location = 'Nigeria'
order by 5 desc

--LOOKING AT COUNTRIES WITH HIGHEST DEATH COUNT
select location, max(total_deaths) as TotalDeathCount
from CovidDeaths
where continent is not null
group by location
order by 2 desc

--LOOKING AT DEATH RATE PER CONTINENT
select continent, max(total_deaths) as TotalDeathCount, MAX(total_deaths/population)*100 as DeathRate
from CovidDeaths
where continent is not null
group by continent
order by 3 desc 
/* Beautiful how Africa, the "Poorest" and "Most Illiterate" continent had the least death rate despite prediction. Some predicted there'd be dead
bodies lying on our streets in Africa.*/

select continent, MAX(total_vaccinations) as TotalVaccinations, MAX(extreme_poverty) as PovertyRate
from CovidVaccinations
where continent is not null
group by continent
order by 3 desc

-- LOOKING AT DEATH RATE PER INCOME CLASS
select location, population, max(total_deaths) as TotalDeathCount, MAX(total_deaths/population)*100 as DeathRate
from CovidDeaths
where location like '%income%'
group by location, population
order by 4 desc
/* Also very funny how the wealthiest and most literate sect of people had the highest death rate. */


--GLOBAL NUMBERS
--DAILY
select date, sum(new_cases) as TotalDailyCases, sum(new_deaths) as TotalDailyDeaths, sum(new_deaths)/sum(new_cases)*100 as DeathPercentage
from CovidDeaths
where continent is not null and new_cases > 0
group by date
order by 1 desc

--VACCINATION VS INFECTION & DEATH
select dea.location, dea.date, vac.total_vaccinations, dea.total_cases, dea.total_deaths
from CovidVaccinations vac
join CovidDeaths dea
	on vac.date = dea.date
	and vac.location = dea.location
where dea.continent is not null
	order by 1,2