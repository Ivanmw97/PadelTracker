# Localization Guide

PadelTracker supports multiple languages through Flutter's official internationalization (i18n) system. This document provides comprehensive information about the localization implementation and how to contribute new translations.

## 🌍 Supported Languages

| Language | Locale | Status | Contributors |
|----------|--------|--------|--------------|
| English | `en` | ✅ Complete | Core team |
| Spanish | `es` | ✅ Complete | Core team |
| Italian | `it` | ✅ Complete | Core team |
| Swedish | `sv` | ✅ Complete | Core team |
| French | `fr` | ✅ Complete | Core team |
| Portuguese | `pt` | ✅ Complete | Core team |

## 📁 File Structure

```
lib/l10n/
├── app_en.arb          # English (template)
├── app_es.arb          # Spanish
├── app_it.arb          # Italian
├── app_sv.arb          # Swedish
├── app_fr.arb          # French
├── app_pt.arb          # Portuguese
└── app_localizations.dart  # Generated file
```

## 🔧 Technical Implementation

### ARB File Format

Each language file follows the Application Resource Bundle (ARB) format:

```json
{
  "@@locale": "en",
  "keyName": "Translated text",
  "@keyName": {
    "description": "Context for translators"
  }
}
```

### Parameterized Strings

For dynamic content, we use parameterized strings:

```json
{
  "winResult": "Win ({setsWon}–{setsLost})",
  "@winResult": {
    "description": "Win result text with sets",
    "placeholders": {
      "setsWon": {
        "type": "int",
        "example": "2"
      },
      "setsLost": {
        "type": "int",
        "example": "1"
      }
    }
  }
}
```

### Usage in Code

```dart
// Simple string
Text(AppLocalizations.of(context)!.homeTitle)

// Parameterized string
Text(AppLocalizations.of(context)!.winResult(2, 1))
```

## 🎯 Translation Categories

### Core Navigation
- Bottom navigation labels
- Page titles
- Section headers

### Match Management
- Match types (Friendly, League, Tournament)
- Playing sides (Left, Right)
- Form fields and validation messages

### Performance Feedback
- Motivational messages based on performance
- Win/loss/draw terminology
- Statistics descriptions

### User Interface
- Buttons and actions
- Empty states
- Error messages and notifications

### Time and Duration
- Time range filters
- Duration formatting
- Date-related text

## 🌐 Adding a New Language

### Step 1: Create ARB File

1. Copy the English template:
   ```bash
   cp lib/l10n/app_en.arb lib/l10n/app_[locale].arb
   ```

2. Update the locale identifier:
   ```json
   {
     "@@locale": "[locale]",
     ...
   }
   ```

### Step 2: Translate Content

Translate all string values while keeping:
- Keys unchanged
- Placeholder syntax intact
- Metadata structure preserved

### Step 3: Update Configuration

Add the new locale to `lib/main.dart`:

```dart
supportedLocales: const [
  Locale('en'),
  Locale('es'),
  Locale('it'),
  Locale('sv'),
  Locale('fr'),
  Locale('pt'),
  Locale('[new_locale]'), // Add here
],
```

### Step 4: Generate and Test

1. Generate localization files:
   ```bash
   flutter gen-l10n
   ```

2. Test the implementation:
   ```bash
   flutter run
   ```

## 📝 Translation Guidelines

### Padel Terminology

Use appropriate padel terms for your language/region:
- **Match types**: Adapt "Friendly/League/Tournament" to local terminology
- **Court sides**: "Left/Right" should use standard directional terms
- **Results**: "Win/Loss/Draw" should use common sports terminology

### Performance Messages

Keep motivational messages:
- **Encouraging**: Positive and supportive tone
- **Contextual**: Appropriate for the user's performance level
- **Cultural**: Adapted to local motivational styles

### User Interface

Maintain consistency:
- **Button text**: Use standard UI conventions for your language
- **Error messages**: Clear and helpful
- **Empty states**: Encouraging and actionable

## 🔍 Quality Assurance

### Testing Checklist

- [ ] All strings display correctly in the UI
- [ ] No text overflow or layout issues
- [ ] Parameterized strings work with different values
- [ ] Performance messages are appropriate
- [ ] Error handling displays correctly
- [ ] Time/date formatting is culturally appropriate

### Common Issues

1. **Text overflow**: Some languages may be longer than English
2. **Cultural adaptation**: Numbers, dates, and cultural references
3. **Terminology consistency**: Use the same terms throughout
4. **Placeholder formatting**: Ensure parameters work correctly

## 🚀 Deployment

### Automatic Detection

The app automatically detects the user's device language and displays the appropriate translation. If the device language is not supported, it falls back to English.

### Manual Testing

To test specific locales during development:

1. Change device language settings
2. Use Flutter's locale override in debug mode
3. Test all major app flows in the target language

## 🤝 Contributing Translations

### What We Need

- **Native speakers** for accurate translations
- **Padel players** familiar with sport terminology
- **Reviewers** to ensure quality and consistency

### Contribution Process

1. **Fork** the repository
2. **Create** a new branch for your language
3. **Add** the new ARB file with complete translations
4. **Update** the supported locales configuration
5. **Test** the implementation thoroughly
6. **Submit** a pull request with detailed description

### Review Process

All translations go through:
- Technical review (format, completeness)
- Native speaker review (accuracy, terminology)
- UI testing (layout, overflow, functionality)

## 📊 Current Statistics

- **Total strings**: 100+ per language
- **Translation coverage**: 100% for all supported languages
- **Supported regions**: Europe, Latin America, North America
- **Active contributors**: Core team + community

## 🎯 Future Plans

### Upcoming Languages
- German (Deutsch) 🇩🇪
- Dutch (Nederlands) 🇳🇱
- Russian (Русский) 🇷🇺

### Enhancements
- Right-to-left (RTL) language support
- Regional dialect variations
- Crowdsourced translation platform
- Professional translation review process

## 📞 Support

For localization questions or issues:
- Open an issue on GitHub with the `localization` label
- Contact the development team
- Join our community discussions

---

*Last updated: December 2025*
*Current version: 6 languages supported*
