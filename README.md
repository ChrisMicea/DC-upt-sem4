# DC - Digital Computers

This is a parent repository that aggregates Digital Computers course materials and projects as git submodules.

## Structure

This repository contains the following submodules:

- **projects/CACHE** - CACHE implementation and related materials
- **projects/ALU** - Arithmetic Logic Unit (ALU) implementation and related materials

Both submodules are individually documented with their own README files.

## Getting Started

### Cloning the Repository

To clone this repository along with all submodules:

```bash
git clone --recursive <repository-url>
```

If you've already cloned without the `--recursive` flag, initialize submodules:

```bash
git submodule init
git submodule update
```

Or combine both:

```bash
git submodule update --init --recursive
```

### Working with Submodules

#### Updating Submodules

To update all submodules to their latest commits:

```bash
git submodule update --remote
```

To update a specific submodule:

```bash
git submodule update --remote <submodule-name>
```

#### Making Changes to a Submodule

1. Navigate to the submodule directory:
   ```bash
   cd projects/CACHE
   ```

2. Make your changes, commit, and push to the submodule's remote:
   ```bash
   git add .
   git commit -m "Your changes"
   git push
   ```

3. Go back to the parent repository and update the submodule reference:
   ```bash
   cd ../..
   git add projects/CACHE
   git commit -m "Update CACHE submodule"
   git push
   ```

#### Checking Submodule Status

To see the status of all submodules:

```bash
git submodule status
```

## Project Overview

This repository contains course materials and projects for Digital Computers. It serves as a centralized hub for the various implementations and learning materials, including CACHE and ALU projects. Each submodule maintains its own version control history and can be developed independently while being tracked together at specific commit points.

## Additional Materials

### Examples

The `Examples/` directory contains example implementations and demonstrations, including:
- Booth multiplication algorithm examples

### Additional Files

- `booth4_sequential_multiplier_architecture.svg` - Architecture diagram for the Booth 4 sequential multiplier