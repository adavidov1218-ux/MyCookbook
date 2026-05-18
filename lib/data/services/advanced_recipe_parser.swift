import Foundation
import NaturalLanguage

struct ParsedRecipe {
    let title: String
    let ingredients: [Ingredient]
    let steps: [Step]
    let rawText: String
}

struct Ingredient: Hashable {
    let name: String
    let amount: String?
    init(name: String, amount: String? = nil) {
        self.name = name.trimmingCharacters(in: .whitespaces)
        self.amount = amount?.trimmingCharacters(in: .whitespaces)
    }
}

struct Step: Hashable {
    let order: Int
    let description: String
}

class AdvancedRecipeParser {
    
    // Весовые индикаторы
    private enum Indicators {
        static let ingredients = ["г", "гр", "кг", "мл", "л", "шт", "ст.л", "ч.л", "стакан", "щепот", "зубчик", "по вкусу", "по желанию", "яйц"]
        static let steps = ["смеша", "добав", "нарез", "очист", "вар", "жар", "пек", "готов", "залей", "влить", "размеш", "взбить", "выложи", "посоли", "поперч"]
        static let noise = ["http", "www", "подпис", "лайк", "реклам", "email", "промокод", "скидка", "сотрудничество", "связь"]
    }
    
    func parse(text: String) -> ParsedRecipe {
        let lines = text.components(separatedBy: .newlines)
            .map { $0.trimmingCharacters(in: .whitespaces) }
            .filter { !$0.isEmpty }
        
        var ingredients: [Ingredient] = []
        var steps: [Step] = []
        
        var currentSection: Section = .unknown
        
        for line in lines {
            let lower = line.lowercased()
            
            // Фильтр шума
            if Indicators.noise.contains(where: { lower.contains($0) }) { continue }
            
            // Определение секции
            if lower.contains("ингредиент") || lower.contains("состав") || lower.contains("продукты") { currentSection = .ingredients; continue }
            if lower.contains("приготовление") || lower.contains("шаг") || lower.contains("процесс") || lower.contains("инструкция") { currentSection = .steps; continue }
            
            // Классификация по весу
            let ingScore = Indicators.ingredients.filter { lower.contains($0) }.count
            let stepScore = Indicators.steps.filter { lower.contains($0) }.count
            
            if ingScore > stepScore || currentSection == .ingredients {
                ingredients.append(extractIngredient(line))
            } else if stepScore >= ingScore || currentSection == .steps {
                steps.append(Step(order: steps.count + 1, description: cleanStep(line)))
            }
        }
        
        return ParsedRecipe(title: extractTitle(lines), ingredients: ingredients, steps: steps, rawText: text)
    }
    
    private func extractIngredient(_ line: String) -> Ingredient {
        // Regex для выделения количества (число + единица)
        let pattern = #"(?<amount>\d+(?:[.,/]\d+)?\s*(?:г|гр|кг|мл|л|шт|ст\.л|ч\.л|стакан|зубчик|шт|яйц[а-я]*))\s+(?<name>.*)"#
        if let regex = try? Regex(pattern), let match = line.firstMatch(of: regex) {
            return Ingredient(name: String(match.output.name), amount: String(match.output.amount))
        }
        return Ingredient(name: line)
    }
    
    private func cleanStep(_ line: String) -> String {
        return line.replacingOccurrences(of: #"^\d+[\.\)\s]+"#, with: "", options: .regularExpression)
    }
    
    private func extractTitle(_ lines: [String]) -> String {
        return lines.first(where: { $0.count > 5 && $0.count < 100 }) ?? "Новый рецепт"
    }
    
    private enum Section { case unknown, ingredients, steps }
}
