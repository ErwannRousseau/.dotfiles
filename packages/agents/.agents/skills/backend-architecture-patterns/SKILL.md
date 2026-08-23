---
name: backend-architecture-patterns
description: "Architecture: design or refactor a business-heavy backend with clear domain boundaries, dependency direction, ports, or bounded contexts. Use when a backend’s business rules, framework coupling, or external integrations make its structure hard to change or test."
---

# Architecture

Build the smallest architecture that keeps business rules explicit and replaceable.

Use this skill for business-heavy systems, framework decoupling, integration seams, or domain boundaries. For straightforward CRUD, retain the codebase’s existing module structure and add layers only when an observable boundary needs one.

## Architecture loop

1. Map the domain.

   Name the business capability, actors, invariants, state changes, inputs, outputs, and external systems. Split terms that mean different things in different parts of the product into bounded contexts.

   Done when every changed rule has one owner and a shared vocabulary.

2. Choose the smallest pattern.

   - Use a focused application service or use case when one operation coordinates domain rules and I/O.
   - Add a domain model when invariants, lifecycles, or calculations must remain true across entry points.
   - Add ports and adapters when an external system, persistence mechanism, or framework must be replaceable or independently testable.
   - Add bounded contexts when the same concept has different rules or language across capabilities.

   Done when each added boundary protects a concrete change or test seam. Remove speculative layers.

3. Draw dependency direction inward.

   Keep domain rules independent from HTTP, ORM, queues, vendor SDKs, and framework types. Application code coordinates use cases through domain-defined ports. Presentation and infrastructure implement those ports at the edge.

   Done when imports flow from adapters toward application and domain, never the reverse.

4. Model consistency.

   Put identity and lifecycle in entities; immutable validated concepts in value objects; rules that span objects in domain services. Choose aggregate boundaries around a single transaction and reference other aggregates by identifier. Publish domain events only after the state change persists.

   Done when each invariant has one transaction owner and cross-boundary work is explicitly asynchronous or compensating.

5. Implement the path end to end.

   Keep controllers, consumers, and jobs thin: validate transport input, invoke one use case, translate its result. Keep repository interfaces specific to domain needs. Keep adapters responsible for databases, networks, and framework configuration.

   Done when an entry point contains no business decision and the use case has no framework dependency.

6. Prove the seam.

   Exercise the real entry point for the changed behavior. Test core rules without a database or network; test adapters at their integration boundary. Check failure paths, transaction ownership, authorization, idempotency, and event delivery when applicable.

   Done when the requested behavior works through its user-facing surface and core rules can run with test doubles.

## Building blocks

| Building block | Owns | Does not own |
| --- | --- | --- |
| Entity | Identity and lifecycle | Persistence details |
| Value object | Immutable value and validation | Identity or side effects |
| Aggregate | Transactional invariants | Cross-aggregate transactions |
| Use case | One application operation | HTTP, ORM, or SDK details |
| Repository port | Aggregate retrieval and persistence contract | Queries unrelated to the aggregate |
| Gateway port | A required external capability | Vendor-specific types |
| Adapter | Database, HTTP, queue, or framework mechanics | Domain policy |
| Domain event | A persisted fact worth reacting to | Synchronous cross-context work |

## Mental models

Use a model only when it changes a concrete boundary or verification step.

| Lens | Choose it when | Apply it |
| --- | --- | --- |
| Hexagonal Architecture (Cockburn) | A framework, database, or vendor integration must be swappable | Define a consumer-shaped port in the core; implement it with an edge adapter. |
| Domain-Driven Design (Evans) | Terms, invariants, or lifecycles carry the product’s complexity | Establish ubiquitous language, aggregates, and bounded contexts around consistency. |
| Clean Architecture (Martin) | Business policy is coupled to delivery or infrastructure | Make dependencies point inward; place framework code at the edge. |
| Information hiding (Parnas) | A module should absorb a likely change | Group code around the hidden decision, not a technical type. |
| Refactoring and patterns (Fowler) | A working system needs structural change | Preserve behavior in small verified moves; introduce a pattern only after the recurring shape appears. |
| Enterprise Integration Patterns (Hohpe, Woolf) | Work crosses process or context boundaries | Make messages explicit, handlers idempotent, and delivery durable when the outcome matters. |

## Architecture checks

- Prefer an existing module boundary before introducing a new abstraction.
- Make ports small and consumer-shaped; an interface with one stable implementation earns its place only at a tested external seam.
- Return application DTOs or domain results across boundaries; never leak ORM or transport objects into the domain.
- Put authorization at the application boundary and input validation at every untrusted boundary.
- Keep read models simple. Use CQRS only when read and write models have distinct scaling, authorization, or consistency needs.
- Persist state before emitting integration-visible events. Use an outbox or equivalent durable handoff when delivery matters.
- Model failures as expected results where callers can recover; reserve exceptions for broken invariants or unexpected faults.

## Review questions

Before finishing, answer each question from the changed code:

1. Which business invariant does this change protect, and where is it enforced?
2. Which dependencies can change independently, and does a port isolate each real seam?
3. Can the core behavior run without the web framework, database, and vendor SDK?
4. Does one use case own the transaction and its resulting events?
5. Can a new developer trace request or message to use case, domain decision, persistence, and response without guessing?

Complete only when every answer maps to a concrete type, module, or runtime check.
