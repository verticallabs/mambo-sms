#- This Source Code Form is subject to the terms of the Mozilla Public
#- License, v. 2.0. If a copy of the MPL was not distributed with this
#- file, You can obtain one at http://mozilla.org/MPL/2.0/.

namespace :dev do
	desc "prepend license to source files"
	task :license do
		license = IO.read("LICENSE")
		MM::Copyrights.process("app", "rb", "#-", license)
		MM::Copyrights.process("app", "haml", "-#-", license)
		MM::Copyrights.process("config", "rb", "#-", license)
		MM::Copyrights.process("config", "yml", "#-", license)
		MM::Copyrights.process("db", "rb", "#-", license)
		MM::Copyrights.process("lib", "rb", "#-", license)
		MM::Copyrights.process("lib", "rake", "#-", license)
		MM::Copyrights.process("spec", "rb", "#-", license)
		MM::Copyrights.process("spec", "yml", "#-", license)
	end
end
