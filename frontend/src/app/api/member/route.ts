import { NextResponse } from "next/server";

const url = "https://jsonplaceholder.typicode.com/posts"
export async function GET(req: Request, res: Response) {
  return new Response("hi");
}

export async function POST(req: Request) {
  const { userId, id, title } = await req.json();
  try {
    const res = await fetch(url, {
      method: "POST",
      headers: {
        "Content-Type": "application/json",
      },
      body: JSON.stringify({ userId, id, title }),
    });
    const data = await res.json();
    // const { fullName, number, login, password, email } = await req.json();
    // console.log("Received data:", { fullName, number, login, password, email });
    console.log("Response data:", data);
    return NextResponse.json(data);
  } catch (err: any) {
    console.error("Error during POST request:", err);
    return new Response(err.message, { status: 500 });
  }
}
