About lammps-metatensor-feedstock
=================================

Feedstock license: [BSD-3-Clause](https://github.com/abmazitov/lammps-metatensor-feedstock/blob/main/LICENSE.txt)

Home: https://docs.metatensor.org/latest/index.html

Package license: BSD-3-Clause

Summary: Metatensor-enabled version of LAMMPS

Development: https://github.com/metatensor/lammps

Documentation: https://docs.lammps.org/Manual.html

Metatensor-enabled version of LAMMPS


Current build status
====================


<table>
</table>

Current release info
====================

| Name | Downloads | Version | Platforms |
| --- | --- | --- | --- |
| [![Conda Recipe](https://img.shields.io/badge/recipe-lammps--metatensor-green.svg)](https://anaconda.org/abmazitov/lammps-metatensor) | [![Conda Downloads](https://img.shields.io/conda/dn/abmazitov/lammps-metatensor.svg)](https://anaconda.org/abmazitov/lammps-metatensor) | [![Conda Version](https://img.shields.io/conda/vn/abmazitov/lammps-metatensor.svg)](https://anaconda.org/abmazitov/lammps-metatensor) | [![Conda Platforms](https://img.shields.io/conda/pn/abmazitov/lammps-metatensor.svg)](https://anaconda.org/abmazitov/lammps-metatensor) |

Installing lammps-metatensor
============================

Installing `lammps-metatensor` from the `abmazitov` channel can be achieved by adding `abmazitov` to your channels with:

```
conda config --add channels abmazitov
conda config --set channel_priority strict
```

Once the `abmazitov` channel has been enabled, `lammps-metatensor` can be installed with `conda`:

```
conda install lammps-metatensor
```

or with `mamba`:

```
mamba install lammps-metatensor
```

It is possible to list all of the versions of `lammps-metatensor` available on your platform with `conda`:

```
conda search lammps-metatensor --channel abmazitov
```

or with `mamba`:

```
mamba search lammps-metatensor --channel abmazitov
```

Alternatively, `mamba repoquery` may provide more information:

```
# Search all versions available on your platform:
mamba repoquery search lammps-metatensor --channel abmazitov

# List packages depending on `lammps-metatensor`:
mamba repoquery whoneeds lammps-metatensor --channel abmazitov

# List dependencies of `lammps-metatensor`:
mamba repoquery depends lammps-metatensor --channel abmazitov
```




Updating lammps-metatensor-feedstock
====================================

If you would like to improve the lammps-metatensor recipe or build a new
package version, please fork this repository and submit a PR. Upon submission,
your changes will be run on the appropriate platforms to give the reviewer an
opportunity to confirm that the changes result in a successful build. Once
merged, the recipe will be re-built and uploaded automatically to the
`abmazitov` channel, whereupon the built conda packages will be available for
everybody to install and use from the `abmazitov` channel.
Note that all branches in the abmazitov/lammps-metatensor-feedstock are
immediately built and any created packages are uploaded, so PRs should be based
on branches in forks and branches in the main repository should only be used to
build distinct package versions.

In order to produce a uniquely identifiable distribution:
 * If the version of a package **is not** being increased, please add or increase
   the [``build/number``](https://docs.conda.io/projects/conda-build/en/latest/resources/define-metadata.html#build-number-and-string).
 * If the version of a package **is** being increased, please remember to return
   the [``build/number``](https://docs.conda.io/projects/conda-build/en/latest/resources/define-metadata.html#build-number-and-string)
   back to 0.

Feedstock Maintainers
=====================

* [@abmazitov](https://github.com/abmazitov/)

