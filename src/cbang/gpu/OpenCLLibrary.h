/******************************************************************************\

          This file is part of the C! library.  A.K.A the cbang library.

                Copyright (c) 2003-2019, Cauldron Development LLC
                   Copyright (c) 2003-2017, Stanford University
                               All rights reserved.

         The C! library is free software: you can redistribute it and/or
        modify it under the terms of the GNU Lesser General Public License
       as published by the Free Software Foundation, either version 2.1 of
               the License, or (at your option) any later version.

        The C! library is distributed in the hope that it will be useful,
          but WITHOUT ANY WARRANTY; without even the implied warranty of
        MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
                 Lesser General Public License for more details.

         You should have received a copy of the GNU Lesser General Public
                 License along with the C! library.  If not, see
                         <http://www.gnu.org/licenses/>.

        In addition, BSD licensing may be granted on a case by case basis
        by written permission from at least one of the copyright holders.
           You may request written permission by emailing the authors.

                  For information regarding this software email:
                                 Joseph Coffland
                          joseph@cauldrondevelopment.com

\******************************************************************************/

#pragma once

#include "ComputeDevice.h"

#include <cbang/os/DynamicLibrary.h>

#include <cbang/util/Singleton.h>

#include <vector>


namespace cb {
  class OpenCLLibrary : public DynamicLibrary, public Singleton<OpenCLLibrary> {
    typedef std::vector<ComputeDevice> devices_t;
    devices_t devices;

  public:
    OpenCLLibrary(Inaccessible);

    unsigned getDeviceCount() const {return devices.size();}
    const ComputeDevice &getDevice(unsigned i) const;

    typedef devices_t::const_iterator iterator;
    iterator begin() const {return devices.begin();}
    iterator end() const {return devices.end();}

  protected:
    VersionU16 getDriverVersion(void *device);
    VersionU16 getComputeVersion(void *device);
    int32_t getVendorID(void *device);
    bool isGPU(void *device);
    void getAMDPCIInfo(void *device, ComputeDevice &cd);
    void getNVIDIAPCIInfo(void *device, ComputeDevice &cd);
    void getPCIInfo(void *device, ComputeDevice &cd);
    ComputeDevice getDeviceInfo(void *device);
  };
}
