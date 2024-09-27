select Location, date, total_cases, new_cases , total_deaths, population
from coviddeaths
order by 1,2;

/* Looking at Total Cases vs Total Deaths and chances of dying*/
select Location, date, total_cases, total_deaths, (total_deaths/total_cases)*100 as DeathPercent
from coviddeaths
where location like '%Bangladesh%'
order by 1,2;

/* Looking at Total Cases vs Population that shows what percentage of population got covid*/
select Location, date, population, total_cases, (total_cases/population)*100 as InfectedRate
from coviddeaths
where location like '%Bangladesh%'
order by 1,2;

/* Looking at Countries with Highest Infection Rate compared to Population*/
select Location,population , max(total_cases), max(total_cases/population)*100 as HighestInfected
from coviddeaths
/*where location like '%Bangladesh%'*/
group by location, population
order by HighestInfected desc;

/* Looking at Countries with Highest Death Rate compared to Population*/
select Location, max(total_deaths) as HighestDeathsCount
from coviddeaths
where continent is not null
group by location
order by HighestDeathsCount desc;


/* Lets break things down by Continent*/
select continent, max(total_deaths) as HighestDeathsCount
from coviddeaths
where continent is not null         
group by continent
order by HighestDeathsCount desc;

/* Global Numbers */
select date,sum(new_cases), sum(new_deaths) , sum(new_deaths)/ sum(new_cases) as DeathPercent
from coviddeaths
where continent is not null
group by date 
order by 1,2;

select sum(new_cases), sum(new_deaths) , sum(new_deaths)/ sum(new_cases) as DeathPercent
from coviddeaths
where continent is not null 
order by 1,2;
 
 /* Looking for Total population vs total vaccinations */
 select cd.continent, cd.location, cd.date, cd.population, cv.new_vaccinations
 , SUM(cv.new_vaccinations) over (partition by cd.location) as vaccineslocation
 from coviddeaths as cd
 join covidvaccination as cv 
 on cd.location= cv.location
 and cd.date= cv.date
 where cd.continent is not null 
 order by 1,2,3;
 



