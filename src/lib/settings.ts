import { supabase } from "./supabase";

export type Settings = {
  id: number;
  opening_times: string | null;
  special_notice: string | null;
  phone_number: string | null;
  email: string | null;
  address: string | null;
  reservation_note: string | null;
};

export async function fetchSettings(): Promise<Settings | null> {
  const { data, error } = await supabase
    .from("settings")
    .select("id, opening_times, special_notice, phone_number, email, address, reservation_note")
    .eq("id", 1)
    .single();

  if (error) {
    console.error("Failed to fetch settings:", error.message);
    return null;
  }

  return data as Settings;
}

export async function saveSettings(payload: Omit<Settings, "id">) {
  const { data, error } = await supabase
    .from("settings")
    .update(payload)
    .eq("id", 1)
    .select("id, opening_times, special_notice, phone_number, email, address, reservation_note")
    .single();

  if (error) {
    throw error;
  }

  return data as Settings;
}
