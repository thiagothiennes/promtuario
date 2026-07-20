using DentalClinic.Core.Domain.Entities;
using FluentValidation;

namespace DentalClinic.Core.Application.Validators
{
    public class PatientValidator : AbstractValidator<Patient>
    {
        public PatientValidator()
        {
            // Regra para Nome: Não vazio e tamanho entre 3 e 150 caracteres
            RuleFor(x => x.Name)
                .NotEmpty().WithMessage("O nome do paciente é obrigatório.")
                .MinimumLength(3).WithMessage("O nome deve ter pelo menos 3 caracteres.")
                .MaximumLength(150).WithMessage("O nome não pode exceder 150 caracteres.");

            // Regra para CPF: Não vazio e formato válido (simples)
            RuleFor(x => x.CPF)
                .NotEmpty().WithMessage("O CPF é obrigatório.")
                .Matches(@"^\d{3}\.\d{3}\.\d{3}-\d{2}$|^\d{11}$")
                .WithMessage("O CPF deve estar no formato XXX.XXX.XXX-XX ou conter 11 dígitos.");

            // Regra para Email: Não vazio e formato válido de email
            RuleFor(x => x.Email)
                .NotEmpty().WithMessage("O email é obrigatório.")
                .EmailAddress().WithMessage("O formato do email é inválido.")
                .MaximumLength(100).WithMessage("O email não pode exceder 100 caracteres.");

            // Regra para Telefone: Não vazio e formato básico
            RuleFor(x => x.Phone)
                .NotEmpty().WithMessage("O telefone é obrigatório.")
                .Matches(@"^\(\d{2}\)\s?\d{4,5}-?\d{4}$|^\d{10,11}$")
                .WithMessage("O telefone deve estar no formato (XX) XXXXX-XXXX ou conter 10-11 dígitos.");
            
            // Regra opcional para Data de Nascimento (se quiser garantir que seja maior de idade ou data válida)
            RuleFor(x => x.DateOfBirth)
                .LessThan(DateTime.Now.AddYears(-18)).WithMessage("O paciente deve ser maior de 18 anos (ou ajuste a validação conforme necessário).")
                .When(x => x.DateOfBirth != default);
        }
    }
}