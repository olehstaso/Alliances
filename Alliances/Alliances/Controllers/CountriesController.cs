using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Alliances.Models;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;

namespace Alliances.Controllers
{
    public class CountriesController : Controller
    {
        private readonly AlliancesDBContext _dbContext;

        public CountriesController()
        {
            _dbContext = new AlliancesDBContext();
        }

        // GET: Countries
        public ActionResult Index()
        {
            var countries = _dbContext.Countries.Include(c=>c.Continent).ToList();
            return View(countries);
        }

        // GET: Countries/Details/5
        public ActionResult Details(Guid id)
        {
            var country = _dbContext.Countries.Include(c => c.Continent).FirstOrDefault(c=>c.Id==id);
            return View(country);
        }

        // GET: Countries/Create
        public ActionResult Create()
        {
            return View();
        }

        // POST: Countries/Create
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Create(IFormCollection collection)
        {
            try
            {
                // TODO: Add insert logic here

                return RedirectToAction(nameof(Index));
            }
            catch
            {
                return View();
            }
        }

        // GET: Countries/Edit/5
        public ActionResult Edit(Guid id)
        {
            var country = _dbContext.Countries.Include(c => c.Continent).FirstOrDefault(c => c.Id == id);
            return View(country);
        }

        // POST: Countries/Edit/5
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Edit(Guid id, IFormCollection collection)
        {
            try
            {
                // TODO: Add update logic here

                return RedirectToAction(nameof(Index));
            }
            catch
            {
                return View();
            }
        }

        // GET: Countries/Delete/5
        public ActionResult Delete(Guid id)
        {
            var country = _dbContext.Countries.Include(c => c.Continent).FirstOrDefault(c => c.Id == id);
            return View(country);
        }

        // POST: Countries/Delete/5
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Delete(Guid id, IFormCollection collection)
        {
            try
            {
                // TODO: Add delete logic here

                return RedirectToAction(nameof(Index));
            }
            catch
            {
                return View();
            }
        }
    }
}