using DentalClinic.Core.Domain.Entities;

namespace DentalClinic.Core.Domain.Repositories;

public interface ITreatmentPlanRepository
{
    Task<TreatmentPlan?> GetActivePlanByPatientIdAsync(int patientId);
    Task<TreatmentPlan?> GetByIdAsync(Guid id);
    Task AddAsync(TreatmentPlan plan);
    Task UpdateAsync(TreatmentPlan plan);
}
