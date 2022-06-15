import Foundation
import dnssd

guard CommandLine.arguments.count == 4 else {
  exit(1)
}
let serviceName = CommandLine.arguments[1]
let serviceType = CommandLine.arguments[2]
let domain = CommandLine.arguments[3]

var serviceRef: DNSServiceRef?
var _resolveReply: DNSServiceResolveReply = { _, _, _, err, _, hosttarget, port, _, _, _ in
  guard err == kDNSServiceErr_NoError else {
    print("error: \(err)")
    exit(1)
  }

  let host = String(cString: hosttarget!)
  let port = UInt16(bigEndian: port)
  print("\(host.trimmingCharacters(in: ["."])):\(port)")
  exit(0)
}

let err = DNSServiceResolve(
  &serviceRef, 0, 0, serviceName, serviceType, domain, _resolveReply, nil)
guard err == kDNSServiceErr_NoError else {
  print("error: \(err)")
  exit(1)
}

let hnd = FileHandle(fileDescriptor: DNSServiceRefSockFD(serviceRef))
hnd.waitForDataInBackgroundAndNotify()
NotificationCenter.default.addObserver(forName: .NSFileHandleDataAvailable, object: nil, queue: nil)
{ _ in
  hnd.waitForDataInBackgroundAndNotify()
  DNSServiceProcessResult(serviceRef)
}

RunLoop.main.run()
