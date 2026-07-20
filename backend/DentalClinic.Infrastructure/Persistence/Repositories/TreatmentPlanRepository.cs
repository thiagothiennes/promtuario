using DentalClinic.Core.Domain.Entities;
using DentalClinic.Core.Domain.Repositories;
using Microsoft.EntityFrameworkCore;

namespace DentalClinic.Infrastructure.Persistence.Repositories;

public class TreatmentPlanRepository : ITreatmentPlanRepository
{
    private readonly ApplicationDbContext _context;

    public TreatmentPlanRepository(ApplicationDbContext context)
    {
        _context = context;
    }

    public async Task<TreatmentPlan?> GetActivePlanByPatientIdAsync(int patientId)
    {
        return await _context.Set<TreatmentPlan>()
            .Include(p => p.Items)
            .FirstOrDefaultAsync(p => p.PatientId == patientId &&
                                     (p.Status == TreatmentPlanStatus.Draft ||
                                      p.Status == TreatmentPlanStatus.Approved ||
                                      p.Status == TreatmentPlanStatus.InProgress));
    }

    public async Task<TreatmentPlan?> GetByIdAsync(Guid id)
    {
        return await _context.Set<TreatmentPlan>()
            .Include(p => p.Items)
            .FirstOrDefaultAsync(p => p.Id == id);
    }

    public async Task AddAsync(TreatmentPlan plan)
    {
        await _context.Set<TreatmentPlan>().AddAsync(plan);
        await _context.SaveChangesAsync();
    }

    public async Task UpdateAsync(TreatmentPlan plan)
    {
        _context.Set<TreatmentPlan>().Update(plan);
        await _context.SaveChangesAsync();
    }
}
