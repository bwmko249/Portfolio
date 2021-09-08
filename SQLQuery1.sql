use [First Project]
select continent, location, date, population, total_cases, new_cases, total_deaths
from dbo.Covid_deaths$
where continent is not null
order by location

--showing death prcentage by country
select location, date, population, total_cases, new_cases, total_deaths, round((total_deaths/total_cases)*100, 2) as death_percentage
from dbo.Covid_deaths$
where continent is not null 
order by location

--showing death percentage in Nigeria
select location, date, population, total_cases, new_cases, total_deaths, round((total_deaths/total_cases)*100, 2) as death_percentage
from dbo.Covid_deaths$
where continent is not null and location = 'Nigeria'
order by location

--showing percentage of population infected
select location, date, population, total_cases, round((total_deaths/total_cases)*100, 2) as death_percentage,  round((total_cases/population)*100, 2) as percentage_infected
from dbo.Covid_deaths$
where continent is not null 
order by location


--contry with the highest infection rate
select location, population, max(total_cases) as overall_infected, round(max(total_cases/population)*100, 2) as percentage_infected
from dbo.Covid_deaths$
where continent is not null 
group by location, population
order by percentage_infected desc


--showing countries with highest death count per population
select location, population, max(total_cases) as overall_infected, max(cast(total_deaths as int)) as overall_deaths
from dbo.Covid_deaths$
where continent is not null
group by location, population
order by overall_deaths  desc


--showing data by continent and worldwide
select location, population, max(total_cases) as overall_infected, 
	max(cast(total_deaths as int)) as overall_deaths,  
	round((max(total_cases)/population)*100, 2) as percentage_infected, 
	max(cast(total_deaths as int))/population*100 as death_percentage,
	(max(cast(total_deaths as int))/max(total_cases))*100 as death_percent_infected
from dbo.Covid_deaths$
where continent is null
group by location, population
order by overall_deaths  desc


--looking at total poulation vs vaccination
select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations
from [First Project]..Covid_deaths$ dea
join [First Project]..Covid_vacc$ vac
	on dea.location = vac.location
	and dea.date = vac.date
where dea.continent is not null
order by location



--Using CTE to perform Calculation on Partition By in previous query
With PopvVac (Continent, Location, Date, Population, New_Vaccinations, Total_vaccinations)
as
(
Select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations
, SUM(CONVERT(int,vac.new_vaccinations)) OVER (Partition by dea.Location Order by dea.location, dea.Date) as Total_vaccinations
--, (RollingPeopleVaccinated/population)*100
From [First Project]..Covid_deaths$ dea
Join [First Project]..Covid_vacc$ vac
	On dea.location = vac.location
	and dea.date = vac.date
where dea.continent is not null 
--order by 2,3
)
Select *, (Total_vaccinations/Population)*100
From PopvVac



-- Using Temp Table to perform Calculation on Partition By in previous query
DROP Table if exists #PercentageVaccinated
Create Table #PercentageVaccinated
(
Continent nvarchar(255),
Location nvarchar(255),
Date datetime,
Population numeric,
New_vaccinations numeric,
Total_vaccinations numeric(22,2)
)

Insert into #PercentageVaccinated
Select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations, 
	SUM(cast(vac.new_vaccinations as bigint)) OVER (Partition by dea.Location Order by dea.location, dea.Date) as Total_vaccinations
From  [First Project]..Covid_deaths$ dea
Join [First Project]..Covid_vacc$ vac
	On dea.location = vac.location
	and dea.date = vac.date
--where dea.continent is not null 
--order by 2,3

Select *, (Total_vaccinations/Population)*100
From #PercentageVaccinated



-- Creating  a View to store data for visualizations
Create View PercentageVaccinated as
Select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations
, SUM(CONVERT(int,vac.new_vaccinations)) OVER (Partition by dea.Location Order by dea.location, dea.Date) as Total_vaccinations
--, (RollingPeopleVaccinated/population)*100
From[First Project]..Covid_deaths$ dea
Join [First Project]..Covid_vacc$ vac
	On dea.location = vac.location
	and dea.date = vac.date
where dea.continent is not null 

