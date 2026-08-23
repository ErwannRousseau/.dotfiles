---
name: convex-dev-geospatial
description: Efficiently query points on a map within a selected region of the globe. Use this skill whenever working with Geospatial or related Convex component functionality.
---

# Geospatial

## Instructions

A geospatial indexing component that enables efficient storage and querying of geographic points within Convex. You can insert points with coordinates, filter keys, and sort keys, then query for all points within rectangular regions or find the nearest points to a given location. The component supports equality filters, range filters on sort keys, and pagination through large result sets while maintaining Convex's consistency and reactivity guarantees.

### Installation

```bash
npm install @convex-dev/geospatial
```

## Use cases

- **Location-based app features** where you need to find nearby restaurants, stores, or services within a user's viewport on a map
- **Fleet management systems** that track vehicle locations and need to efficiently query which vehicles are in specific geographic regions
- **Real estate platforms** filtering properties by price range within map boundaries, with results sorted by price or distance
- **Event discovery apps** finding concerts, meetups, or activities within walking distance of a user's location
- **Asset tracking applications** monitoring equipment or inventory across geographic regions with complex filtering requirements

## How it works

The component installs as a Convex component and provides a `GeospatialIndex` class that wraps the underlying geospatial storage. You insert points using the `insert()` method with coordinates, optional filter keys for querying, and sort keys for result ordering. The component stores points in an indexed structure that enables efficient rectangular and nearest-neighbor queries.

For querying, the `query()` method accepts rectangular shapes and supports filter conditions including `eq()` for exact matches, `in()` for set membership, and range conditions like `gte()` and `lt()` on sort keys. The `nearest()` method finds closest points to a query location with optional maximum distance constraints. Both query types return paginated results with cursor-based continuation for large datasets.

The component integrates with Convex's mutation and query functions, maintaining consistency and reactivity. All geographic computations happen server-side using the indexed data structure, avoiding expensive client-side distance calculations while leveraging Convex's automatic caching and real-time updates.

## When NOT to use

- When a simpler built-in solution exists for your specific use case
- If you are not using Convex as your backend
- When the functionality provided by Geospatial is not needed

## Resources

- [npm package](https://www.npmjs.com/package/%40convex-dev%2Fgeospatial)
- [GitHub repository](https://github.com/get-convex/geospatial)
- [Convex Components Directory](https://www.convex.dev/components/geospatial)
- [Convex documentation](https://docs.convex.dev)