import { Dock } from "@/components/global/dock";
import Image from "next/image";

export default function Home() {
  return (
    <main className="flex min-h-screen flex-col  p-2">
      <div className="flex flex-col items-center justify-center gap-4 p-4">
        <Image
          src="/next.svg"
          alt="dMag logo"
          width={200}
          height={200}
          className="rounded-full"
        />
        <h1 className="text-4xl font-bold">dMag</h1>
        <p className="text-lg">
          dMag is a just for fun project

        </p>
      </div>
    </main>
  );
}
