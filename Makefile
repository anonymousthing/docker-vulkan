# Copyright (c) 2020, NVIDIA CORPORATION.  All rights reserved.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

DOCKER   ?= docker
REGISTRY ?= ghcr.io/anonymousthing

VULKAN  ?= 1.2.203
CUDA    ?= 11.0.3
VERSION ?= beta.0

FULL_VERSION := $(VULKAN)-cuda-$(CUDA)-$(VERSION)

.PHONY: all
all: ubuntu20.04

push:
	$(DOCKER) push "$(REGISTRY)/vulkan:$(FULL_VERSION)-ubuntu20.04"

push-short:
	$(DOCKER) tag "$(REGISTRY)/vulkan:$(FULL_VERSION)-ubuntu20.04" "$(REGISTRY)/vulkan:$(VULKAN)"
	$(DOCKER) push "$(REGISTRY)/vulkan:$(VULKAN)"

push-latest:
	$(DOCKER) tag "$(REGISTRY)/vulkan:$(FULL_VERSION)-ubuntu20.04" "$(REGISTRY)/vulkan:$(VULKAN)"
	$(DOCKER) push "$(REGISTRY)/vulkan:$(VULKAN)"

ubuntu20.04:
	$(DOCKER) build --pull \
		--build-arg VULKAN_VERSION="v$(VULKAN)" \
		--build-arg CUDA_VERSION="$(CUDA)" \
		--tag "$(REGISTRY)/vulkan:$(FULL_VERSION)-ubuntu20.04" \
		--file docker/Dockerfile.ubuntu20.04 .
