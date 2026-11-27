# Repository Guidelines

## 1. Project Context

- This is a Ruby on Rails application using PostgreSQL.
- The frontend uses ERB, Hotwire (Turbo and Stimulus), Importmap, and Tailwind CSS.
- Follow the existing Rails application structure and conventions.
- Inspect relevant code and configuration before proposing or implementing changes.
- Keep changes focused on the requested task.
- Avoid unrelated modifications, unnecessary abstractions, and overengineering.

## 2. Development Environment

- The development environment is Ubuntu on WSL.
- Vim is the primary code editor.
- Prefer terminal-based development tools and workflows.
- Git and GitHub are used for version control and collaboration.
- Do not assume external services, credentials, environment variables, or local machine configurations are available.
- Never expose, print, or commit secrets, credentials, or sensitive environment variables.

## 3. Rails and Application Code

- Follow idiomatic Ruby and established Rails conventions.
- Write clean, readable, maintainable, and modular code.
- Respect the existing application architecture and naming conventions.
- Preserve existing model relationships, validations, callbacks, authorization, and controller behaviour unless the requested change requires modifications.
- Consider security, performance, and maintainability when changing application functionality.
- Avoid unnecessary dependencies. Explain and obtain approval before adding or changing dependencies.
- Obtain approval before significant architectural changes.
- Treat existing migrations, schema, models, and database constraints as important sources of truth when working with database functionality.

## 4. Database Safety

- Preserve existing data and database integrity.
- Inspect relevant models, migrations, schema, associations, and constraints before proposing database changes.
- Explain proposed schema changes and migration implications.
- Do not execute migrations without explicit approval.
- Never reset, recreate, drop, truncate, or otherwise destructively modify a database without explicit approval.
- Never bypass foreign keys, validations, or database constraints simply to make an operation succeed.
- Never execute database operations against production without explicit authorization.

## 5. Testing Standards

- RSpec is the preferred testing framework for new and modified tests.
- Use Factory Bot and Shoulda Matchers where appropriate.
- This repository also contains Rails Minitest tests under `test/`. Inspect existing tests in the affected area and avoid unnecessary duplication.
- Write meaningful tests covering expected behaviour, relevant edge cases, and failure scenarios.
- When implementing or modifying application functionality, run relevant tests where practical.
- Prefer focused tests over unnecessarily running the entire test suite.
- Investigate test failures before changing application code or tests.
- Never modify tests simply to make them pass.
- Keep testing and debugging focused and efficient.
- Never run tests against production data.

## 6. Git Workflow

- Follow Conventional Commits for commit messages.
- Use clear, descriptive commit messages that accurately represent the changes.
- Review Git diffs before committing.
- Ensure commits contain only relevant changes.
- Never discard, overwrite, or rewrite existing user changes without approval.
- Do not commit, push, merge, or open pull requests without explicit approval.
- When asked to prepare a pull request, generate a clear description containing:
  - Summary of changes.
  - Motivation and purpose.
  - Implementation details.
  - Tests performed.
  - Relevant outstanding issues.

## 7. Documentation Standards

- Keep README files accurate and relevant to the actual application.
- Document the following where applicable:
  - Project overview and purpose.
  - Prerequisites and dependencies.
  - Installation and setup instructions.
  - Environment configuration.
  - Database setup.
  - Running the application.
  - Running tests.
  - Important application functionality.
- Verify commands and configuration against the actual repository before documenting them.
- Never invent application features, dependencies, commands, or configuration details.
- Keep documentation concise, useful, and maintainable.

## 8. AI Agent Workflow

- Inspect relevant files before making changes.
- Understand the existing implementation before suggesting replacements or refactoring.
- Work autonomously on explicitly requested, routine, and reversible tasks.
- Explain substantial changes and their implications before implementation.
- Obtain explicit approval before:
  - Destructive operations.
  - Executing database migrations.
  - Adding or changing dependencies.
  - Significant architectural changes.
  - Committing, pushing, merging, or opening pull requests.
  - Discarding or overwriting existing user work.
- Do not modify unrelated files.
- Prefer the simplest appropriate solution.
- When uncertain, explain the uncertainty instead of guessing.
- Avoid unnecessary investigations that do not materially affect application stability, security, data integrity, or delivery.
- Do not repeatedly investigate low-impact discrepancies that do not prevent the requested work.
- Keep progress updates and final responses concise, practical, and technically accurate.

## 9. Project-Specific Guidance

- The application uses PostgreSQL.
- Students have many-to-many relationships with Courses through Enrollments.
- Students have many-to-many relationships with Projects through StudentProjects.
- Devise is used for administrator authentication.
- RSpec and Rails Minitest are both present in the repository.
- Preserve existing application relationships and functionality when extending the application.
- Verify implementation details against the actual code rather than relying solely on this description.
